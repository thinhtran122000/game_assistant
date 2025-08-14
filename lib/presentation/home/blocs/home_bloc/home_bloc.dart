import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:game_assistant/data/models/assistant/assistant_model.dart';
import 'package:game_assistant/repository/assistant_repository.dart';
import 'package:injectable/injectable.dart';

part 'home_event.dart';
part 'home_state.dart';

@lazySingleton
class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final AssistantRepository assistantRepository = AssistantRepository();
  HomeBloc() : super(HomeInitial(listAssistant: [])) {
    on<FetchAssistants>(_onFetchAssistants);
    on<CreateAssistant>(_onCreateAssistant);
    on<DeleteAssistant>(_onDeleteAssistant);
  }

  FutureOr<void> _onFetchAssistants(FetchAssistants event, Emitter<HomeState> emit) async {
    try {
      final result = await assistantRepository.getAssistants();
      emit(HomeInitial(listAssistant: result));
    } catch (e) {
      emit(HomeError(
        listAssistant: state.listAssistant,
        errorMessage: e.toString(),
      ));
    }
  }

  FutureOr<void> _onCreateAssistant(CreateAssistant event, Emitter<HomeState> emit) async {
    try {
      final result = await assistantRepository.createAssistant(
        name: '${event.gameName} Assistants',
        instructions: getInstructions(event.gameName),
        model: 'gpt-4o-mini',
        tools: getTools(),
        responseFormat: getResponseFormat(),
        metadata: {
          'image_url': event.imageGame,
        },
      );
      emit(HomeInitial(listAssistant: [result, ...state.listAssistant]));
    } catch (e) {
      emit(HomeError(
        listAssistant: state.listAssistant,
        errorMessage: e.toString(),
      ));
    }
  }

  FutureOr<void> _onDeleteAssistant(DeleteAssistant event, Emitter<HomeState> emit) async {
    try {
      final currentList = [...state.listAssistant];
      currentList.removeWhere((element) => element.id == event.assistantId);
      emit(HomeInitial(listAssistant: currentList));
      await assistantRepository.deleteAssistant(assistantId: event.assistantId);
    } catch (e) {
      emit(HomeError(
        listAssistant: state.listAssistant,
        errorMessage: e.toString(),
      ));
    }
  }
}

String getInstructions(String gameName) =>
    '''You will become a large language model help users find latest comprehensive information about $gameName.
    Rules:
1. Identify the Query: Understand the specific question or information request about $gameName from user.
2. Source Understanding: Break down the query into different categories.
3. Gather Information:
    - Pull comprehensive details from your trained knowledge base related to the specific categories identified.
    - Ground more information from the global internet (Ex: fanpage, home page, community resources, in-game experience, official sources, total information platform etc.) and extract the unique information which is relevant to the game topic.
    - Always provide real-time information by using concurrently both "web_search_youtube_resource" and "web_search_and_summarize" function already defined and attached on you to get the comprehensive details of unique latest information from the global internet.
    - Detect and summarize the matching information containing in response of both "web_search_youtube_resource" and "web_search_and_summarize" function to the final overall information.
4. Organize Response: Structure the response according to the user's request, ensuring clarity and thoroughness, including providing different unique URL link resource containing information related to the game topic, that user is mentioning in question.
5. Optimize for User: Make sure the response is user-friendly, addresses the user's needs, and is easy to understand.
6. Optimize Response: Make the response more engaging and visually appealing by using phone/keyboard's emojis suitable for each content to express your emotions when interacting with user.
    Notes:
Please extract the main query from the user's question exactly as it is stated. Do not add any additional terms, context, or time-related references (such as years or dates). The goal is to maintain the original intent of the user's question without modification.
Example: 
    -> User asks: "How many reward tiers are in the Clan Games?",
    -> The property query identified in "web_search_and_summarize" & "web_search_youtube_resource" function: "How many reward tiers are in the Clan Games?"
    ''';

List<Map<String, dynamic>> getTools() => [
      {
        'type': 'function',
        'function': {
          'name': 'web_search_youtube_resource',
          'description':
              '''Searches the web for publicly available information from youtube resource, summarizes the key findings, and provides the source for more details.''',
          'strict': true,
          'parameters': {
            'type': 'object',
            'required': [
              'query',
            ],
            'properties': {
              'query': {
                'type': 'string',
                'description': 'The unique original search term used to find relevant information.',
              },
            },
            'additionalProperties': false,
          },
        },
      },
      {
        'type': 'function',
        'function': {
          'name': 'web_search_and_summarize',
          'description':
              '''Searches the web for publicly available information (Ex: fanpage, home page, community resources, in-game experience, official sources, total information platform etc.), summarizes the key findings, and provides the source for more details.''',
          'strict': true,
          'parameters': {
            'type': 'object',
            'required': [
              'query',
            ],
            'properties': {
              'query': {
                'type': 'string',
                'description': 'The unique original search term used to find relevant information.',
              },
            },
            'additionalProperties': false,
          },
        },
      },
    ];

Map<String, dynamic> getResponseFormat() => {
      'type': 'json_schema',
      'json_schema': {
        'name': 'answer_response',
        'schema': {
          'type': 'object',
          'properties': {
            'text': {
              'type': 'object',
              'properties': {
                'type': {
                  'type': 'string',
                },
                'value': {
                  'type': 'string',
                  'description': 'Message of assistant responded.',
                },
              },
              'required': ['type', 'value'],
              'additionalProperties': false,
            },
            'images': {
              'type': 'object',
              'properties': {
                'type': {
                  'type': 'string',
                },
                'image_url': {
                  'type': 'array',
                  'description':
                      """The list of image urls in key json ["cse_image"] collected from 'web_search_and_summarize' function, related to user's request.""",
                  'items': {
                    'type': 'string',
                    'description': "The image url related to message of assistant's response.",
                  },
                },
              },
              'required': ['type', 'image_url'],
              'additionalProperties': false,
            },
            'videos': {
              'type': 'object',
              'properties': {
                'type': {
                  'type': 'string',
                },
                'video_url': {
                  'type': 'array',
                  'description': '''The list contains items video url.''',
                  'items': {
                    'type': 'string',
                    'description':
                        'The video url (Ex: https://www.youtube.com/watch?v=YOUTUBE_VIDEO_ID, https://www.tiktok.com/USER_NAME/video/TIKTOK_VIDEO_ID)',
                  },
                },
              },
              'required': ['type', 'video_url'],
              'additionalProperties': false,
            },
            'resources': {
              'type': 'object',
              'properties': {
                'type': {
                  'type': 'string',
                },
                'resource_list': {
                  'type': 'array',
                  'description':
                      'The list contains items of both resource url and icon page from fanpage, homepage,community,etc.',
                  'items': {
                    'type': 'object',
                    'properties': {
                      'resource_name': {
                        'type': 'string',
                        'description':
                            'The name of resource page match domain url (Ex: https://www.youtube.com has name is Youtube)',
                      },
                      'resource_url': {
                        'type': 'string',
                        'description': 'The resource url',
                      },
                      'site_icon_url': {
                        'type': 'string',
                        'description':
                            'The icon of resource site (Ex: https://www.youtube.com/favicon.ico, https://www.reddit.com/favicon.ico, https://www.tiktok.com/favicon.ico,etc).',
                      },
                    },
                    'additionalProperties': false,
                    'required': ['resource_name', 'resource_url', 'site_icon_url'],
                  },
                },
              },
              'required': ['type', 'resource_list'],
              'additionalProperties': false,
            },
          },
          'required': ['text', 'images', 'videos', 'resources'],
          'additionalProperties': false,
        },
        'strict': true,
      },
    };
