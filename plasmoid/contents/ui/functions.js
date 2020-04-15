function loadfile(path, css) {
    if (path == "") {
        setText("<p>Please specify a markdown file in the plasmoid settings</p>", css)
    } else {
        var xhr = new XMLHttpRequest
        xhr.open("GET", path)
        xhr.onreadystatechange = function() {
            if (xhr.readyState == XMLHttpRequest.DONE) {
                var mdText = xhr.responseText
                
                var htmlText = ""
                
                var lines = mdText.split("\n")
                
                for (var line in lines) {
                    line = lines[line]
                    
                    var head = /^\s{0,3}(\#{1,6})\s+(.*?)\s*#*\s*$/.exec(line)
                    if (head) {
                        line = "<h" + head[1].length + ">" + head[2] + "</h" + head[1].length + ">"
                        htmlText += line
                        continue
                    } else {
                        line = "<p>" + line + "</p>"
                        htmlText += line
                        continue
                    }
                }
                
                var md = markdownit()
                setText(md.render(mdText), css)
                
            }
        };
        xhr.send()
    }
}

function setText(outputText, css) {
    viewtext.text = "<style>td,th {padding: 10px;} table {border-width: 1px;margin: 15px;}"+ css +"</style>" + outputText
}

var locked = false
function hideText() {    
    if (locked == false) {
        hideButton.text = "Show Notes"
        reload.visible = false
        
        scrollview.visible = false
        lockedSign.visible = true
        mouseArea.enabled = false
        
        locked = true
    } else {
        hideButton.text = "Hide Text"
        loadfile()
        reload.visible = true
        
        scrollview.visible = true
        lockedSign.visible = false
        mouseArea.enabled = true
        
        locked = false
    }
}
