import 'package:game_assistant/data/models/index.dart';

class RunModel {
  String? id;
  String? assistantId;
  int? cancelledAt;
  int? completedAt;
  int? createdAt;
  int? expiresAt;
  int? failedAt;
  IncompleteDetailsModel? incompleteDetails;
  String? instructions;
  LastError? lastError;
  int? maxCompletionTokens;
  int? maxPromptTokens;
  Map<String, String>? metadata;
  String? model;
  String? object;
  bool? parallelToolCalls;
  RequiredAction? requiredAction;
  Map<String, dynamic>? responseFormat;
  int? startedAt;
  String? status;
  String? threadId;
  String? toolChoice;
  List<ToolModel> tools;
  TruncationStrategy? truncationStrategy;
  Usage? usage;
  double? temperature;
  double? topP;
  ToolResources? toolResources;
  String? reasoningEffort;

  RunModel({
    this.id,
    this.assistantId,
    this.cancelledAt,
    this.completedAt,
    this.createdAt,
    this.expiresAt,
    this.failedAt,
    this.incompleteDetails,
    this.instructions,
    this.lastError,
    this.maxCompletionTokens,
    this.maxPromptTokens,
    this.metadata,
    this.model,
    this.object,
    this.parallelToolCalls,
    this.requiredAction,
    this.responseFormat,
    this.startedAt,
    this.status,
    this.threadId,
    this.toolChoice,
    this.tools = const [],
    this.truncationStrategy,
    this.usage,
    this.temperature,
    this.topP,
    this.toolResources,
    this.reasoningEffort,
  });

  factory RunModel.fromJson(Map<String, dynamic> json) => RunModel(
        id: json['id'],
        assistantId: json['assistant_id'],
        cancelledAt: json['cancelled_at'],
        completedAt: json['completed_at'],
        createdAt: json['created_at'],
        expiresAt: json['expires_at'],
        failedAt: json['failed_at'],
        incompleteDetails:
            json['incomplete_details'] == null ? null : IncompleteDetailsModel.fromJson(json['incomplete_details']),
        instructions: json['instructions'],
        lastError: json['last_error'] == null ? null : LastError.fromJson(json['last_error']),
        maxCompletionTokens: json['max_completion_tokens'],
        maxPromptTokens: json['max_prompt_tokens'],
        metadata: json['metadata'] == null ? {} : Map.from(json['metadata']),
        model: json['model'],
        object: json['object'],
        parallelToolCalls: json['parallel_tool_calls'],
        requiredAction: json['required_action'] == null ? null : RequiredAction.fromJson(json['required_action']),
        responseFormat: json['response_format'] == null ? {} : Map<String, dynamic>.from(json['response_format']),
        startedAt: json['started_at'],
        status: json['status'],
        threadId: json['thread_id'],
        toolChoice: json['tool_choice'],
        tools: json['tools'] == null ? [] : List<ToolModel>.from(json['tools'].map((x) => ToolModel.fromJson(x))),
        truncationStrategy:
            json['truncation_strategy'] == null ? null : TruncationStrategy.fromJson(json['truncation_strategy']),
        usage: json['usage'] == null ? null : Usage.fromJson(json['usage']),
        temperature: json['temperature'],
        topP: json['top_p'],
        toolResources: json['tool_resources'] == null ? null : ToolResources.fromJson(json['tool_resources']),
        reasoningEffort: json['reasoning_effort'],
      );
}

class LastError {
  String? code;
  String? message;

  LastError({
    this.code,
    this.message,
  });

  factory LastError.fromJson(Map<String, dynamic> json) => LastError(
        code: json['code'],
        message: json['message'],
      );
}

class RequiredAction {
  String? type;
  SubmitToolOutputs? submitToolOutputs;

  RequiredAction({
    this.type,
    this.submitToolOutputs,
  });

  factory RequiredAction.fromJson(Map<String, dynamic> json) => RequiredAction(
        type: json['type'],
        submitToolOutputs:
            json['submit_tool_outputs'] == null ? null : SubmitToolOutputs.fromJson(json['submit_tool_outputs']),
      );
}

class SubmitToolOutputs {
  List<ToolCall> toolCalls;

  SubmitToolOutputs({
    this.toolCalls = const [],
  });

  factory SubmitToolOutputs.fromJson(Map<String, dynamic> json) => SubmitToolOutputs(
        toolCalls:
            json['tool_calls'] == null ? [] : List<ToolCall>.from(json['tool_calls'].map((x) => ToolCall.fromJson(x))),
      );
}

class ToolCall {
  String? id;
  String? type;
  FunctionObject? function;

  ToolCall({
    this.id,
    this.type,
    this.function,
  });

  factory ToolCall.fromJson(Map<String, dynamic> json) => ToolCall(
        id: json['id'],
        type: json['type'],
        function: json['function'] == null ? null : FunctionObject.fromJson(json['function']),
      );
}

class FunctionObject {
  String? name;
  String? arguments;

  FunctionObject({
    this.name,
    this.arguments,
  });

  factory FunctionObject.fromJson(Map<String, dynamic> json) => FunctionObject(
        name: json['name'],
        arguments: json['arguments'],
      );
}

class TruncationStrategy {
  String? type;
  int? lastMessages;

  TruncationStrategy({
    this.type,
    this.lastMessages,
  });

  factory TruncationStrategy.fromJson(Map<String, dynamic> json) => TruncationStrategy(
        type: json['type'],
        lastMessages: json['last_messages'],
      );
}

class Usage {
  int? promptTokens;
  int? completionTokens;
  int? totalTokens;

  Usage({
    this.promptTokens,
    this.completionTokens,
    this.totalTokens,
  });

  factory Usage.fromJson(Map<String, dynamic> json) => Usage(
        promptTokens: json['prompt_tokens'],
        completionTokens: json['completion_tokens'],
        totalTokens: json['total_tokens'],
      );
}
