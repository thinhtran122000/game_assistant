import 'package:flutter_dotenv/flutter_dotenv.dart';

class Constants {
  static String openAIHost = dotenv.env['OPEN_AI_HOST'] ?? '';
  static String openAiApiKey = dotenv.env['OPEN_AI_API_KEY'] ?? '';
  static String googleHost = dotenv.env['GOOGLE_HOST'] ?? '';
  static String googleApiKey = dotenv.env['GOOGLE_API_KEY'] ?? '';
  static String engineId = dotenv.env['GOOGLE_ENGINE_ID'] ?? '';
  static const String sortOrder = 'date:d:h';
}

final List<Game> listGame = [
  Game(
    gameName: 'Genshin Impact',
    imageGame:
        'https://play-lh.googleusercontent.com/-gSYfE68AvxlSAiKzXThyDw1-iUlwBJGsJBAXllBA8i_NM7kvft32U2DYSmQFglaOaw=s48-rw',
  ),
  Game(
    gameName: 'Minecraft',
    imageGame:
        'https://play-lh.googleusercontent.com/27O5tpaYE82W6m30rJ_MX3-UvshlDM6O8oXDxb6GseYW2T7P8UNT19727MGmz-0q3w=s48-rw',
  ),
  Game(
    gameName: 'Arena Of Valor',
    imageGame:
        'https://play-lh.googleusercontent.com/5U5CfcgH2zmrYrSBFR8zje3ht9HTrmOcDek1wcJdL1z9a5KnS9bxo4WYoeQ6_Nd5EA=w240-h480-rw',
  ),
  Game(
    gameName: 'League of Legends: Wild Rift',
    imageGame:
        'https://play-lh.googleusercontent.com/99Mn2EUqL81ICRnIVPHlhNC71wwE-vRtqrDgkRtOAAH6sjJFCc48nttpx8M-35lNuN-w=s48-rw',
  ),
  Game(
    gameName: 'Clash Of Clans',
    imageGame:
        'https://play-lh.googleusercontent.com/LByrur1mTmPeNr0ljI-uAUcct1rzmTve5Esau1SwoAzjBXQUby6uHIfHbF9TAT51mgHm=s48-rw',
  ),
  Game(
    gameName: 'Free Fire',
    imageGame:
        'https://play-lh.googleusercontent.com/6llpraFcTI0rEUuRpWEG9NWWblvm106y5JXcDzu60ACuaUYDD3i70a-p9_QM65NsGDE=s48-rw',
  ),
  Game(
    gameName: 'PUBG Mobile VN',
    imageGame:
        'https://play-lh.googleusercontent.com/E_bwpvmFEiRGW4G9VnTIpoJ4XM-3udz3Jm2cDBVsavyu4pT12x2hNLI1ucWoS2KaQIoA=s48-rw',
  ),
  Game(
    gameName: 'Rise of Kingdoms - Gamota',
    imageGame:
        'https://play-lh.googleusercontent.com/iY0FF9fEIuHLxPvWtFXk372qB_KSalLZwg-YlLUtX3q2IpjuprtHIiuFbulXEOMKwow=s48-rw',
  ),
];

class Game {
  String? gameName;
  String? imageGame;
  Game({this.gameName, this.imageGame});
}












//   static const String instructions =
//       '''Create a language model prompt to help users find comprehensive information about Genshin Impact, including lore, character builds, strategies, and tips.

// The task involves providing detailed and organized responses to any query related to the video game "Genshin Impact." The model should cover various aspects such as in-game lore, character development, strategies for gameplay, builds for characters, and general tips. The responses should be accurate, detailed, and tailored to the information needs of the user.

// # Steps

// 1. **Identify the Query**: Understand the specific question or information request about Genshin Impact from the user.
// 2. **Source Understanding**: Break down the query into categories such as lore, character builds, strategies, or tips.
// 3. **Gather Information**: Pull comprehensive details from your trained knowledge base related to the specific categories identified.
// 4. **Organize Response**: Structure the response according to the user's request, ensuring clarity and thoroughness.
// 5. **Optimize for User**: Make sure the response is user-friendly, addresses the user's needs, and is easy to understand.

// # Output Format

// Provide an organized response tailored to the user's query about Genshin Impact.
// Use paragraphs to separate different types of information (e.g., lore separate from tips).
// Ensure that relevant details are concise yet thorough, making use of bullet points for lists when appropriate.

// # Examples

// **Example 1:**
// **Input**: "Tell me about the lore behind Mondstadt in Genshin Impact."
// **Response**:
//   - Lore of Mondstadt: Mondstadt, often referred to as the City of Freedom, is ruled by the Anemo Archon, Barbatos. It is known for its free-spirited culture and love for music. Historically, Mondstadt fought for freedom against oppressive rule, leading to its current state. Key events include...

// **Example 2:**
// **Input**: "What is the best build for Klee?"
// **Response**:
//   - Best Build for Klee: Focus on maximizing elemental burst and pyro damage. Recommended artifacts are the Crimson Witch of Flames set for increased pyro damage. For weapons, consider the Skyward Atlas for enhanced elemental damage…

// # Notes

// Keep the response updated with the latest information up to October 2023.
// Pay special attention to emerging strategies or newly introduced characters and updates in the game. ''';