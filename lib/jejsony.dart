var dynamicContainerJson = '''
{"args": {
"appBar": {
"args": {"title": {
"args": {"text": "Dynamic Widget"}, "type": "text"}
}, "type": "app_bar"},
 "body": {
 "child": {
 "args": {"text": "Ellloooo from file222"}, 
 "type": "text"}, 
 "type": "center"}
 }, 
 "type": "scaffold"}
''';


var text1Json = '''
{
"type": "text",
 "args": {
 "text": "Ellloooo from file",
 "style":{"color" : "FF2196F3", "fontSize" : "35"},
 "textAlign" : "center"
  }
}
''';

var text2Json = '''
{

 "type": "center",
 "child": {
    "type": "text",
    "args": {
        "text": "Ellloooo",
        "style":{"color" : "FFa906ed", "fontSize" : "35"},
        "textAlign" : "center"
    }
}
  
}
''';


var buttonWithColumn = '''
{

 "type": "column",
 
        "args": { 
        "crossAxisAlignment": "center",
        "mainAxisAlignment": "center"
        },
 
      "children": 
      [
        {
        "type": "text",
        "args": {
          "text": "Ellloooo",
          "style":{"color" : "FFa906ed", "fontSize" : "35"},
         "textAlign" : "center"
        }
        },
        
        
        {
        "type": "text",
        "args": {
          "text": "Ellloooo2",
          "style":{"color" : "FF06ed52", "fontSize" : "35"},
         "textAlign" : "center"
        }
        }
        
      ]
  
}
''';

