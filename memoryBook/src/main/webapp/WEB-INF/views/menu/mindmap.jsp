<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
	
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset= UTF-8" >
<meta name="viewport"
	content="width=device-width, initial-scale=1, shrink-to-fit=no">
<meta name="description" content="">
<meta name="author" content="">
<title>마인드맵</title>
<script src="http://code.jquery.com/jquery-3.2.1.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/gojs/1.7.23/go-debug.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/gojs/1.7.24/go.js"></script>

</head>
<body>
<div class="container show-grid" id="sample" style="padding-top: 60px;">
<div class="row">

<h3 class="tit_brunch">드래그가 글이 되는 공간, 드래그노트</h3>
			<p class="desc_brunch">
				<span class="part">노트가 마인드맵으로 되는 공간<br></span>
				

	<div class="col-md-6">
	<div class="text-left">			
  <div style="width:300%; white-space:nowrap;">
     <!-- <span style="display: inline-block; vertical-align: top">
      <div class="palettezone" id="testpalettezone">
        <div class="draggable" draggable="true">Water</div>
        <div class="draggable" draggable="true">Coffee</div>
        <div class="draggable" draggable="true">Tea</div>
      </div> 
    </span> -->
    <span style="display: inline-block; vertical-align: top">
      <div class="dropzone" id="myDiagramDiv" style="border: solid 1px black; width:1000px; height:650px;">
      </div>
    </span>
    
  </div>

<br><br>
<div class = "control">
<button id="NewButton" onclick="newmap()">newmap</button>
<button id="SaveButton" onclick="save()">Save</button>
<button id="LoadButton" onclick="load()">Load</button>
<button id="DeleteButton" onclick="deletemap()">Delete</button>
</div>
<div id="loadedjson">

<p>여기가 제이슨 로드 지역</p>

</div>
</div><!-- text-center -->
</div><!-- class col-md-4  -->

 

<!-- <div id="mindView" class="viewList">
		<div class="list_title">
		<div class="deleteZone" ondrop="drop(event)" ondragover="allowDrop(event)">
		</div>
			<br>
			<h3 class="tit_brunch">드래그가 글이 되는 공간, 드래그노트</h3>
			<p class="desc_brunch">
				<span class="part">노트가 마인드맵으로 되는 공간<br></span>
				검색
				<div class="searchInput col-md-offset">
					<div class="search-form">
		            		<label for="search" class="sr-only">Search</label>
		            		<input type="text" class="form-control" name="searchWrd2" id="searchWrd2" placeholder="노트 검색" onkeydown="javascript:if(event.keyCode == 13) searchList();">
		        	</div>
				</div>
		<div class="btn-default noteSearch_btn" id="noteSearch_btn2" onclick="searchList2();"><img src="/memory/resources/img/search_icon.jpg"></div>
		</div> -->
		<br><br><br>
		
	<!-- 	<div class="alert alert-info alert-dismissable">
        <a class="panel-close close" data-dismiss="alert">×</a> 
        <i class="fa fa-coffee"></i>
      </div> -->
		
</div>
	  </div> <!-- div row -->
		 <div class="col-md-6">
	  <div class="row">
        	카테고리 선택
		<ul class="nav nav-tabs" id="categoryList2">

		</ul>
		<div class="tab-content">
			<br>
			
			<div id="mindCardList" class="mindCardList List"></div>
		</div>
<!-- <textarea id="mySavedModel" style="width:50%;height:100px"></textarea> -->
	</div><!-- col-md-8 col sm -->
	</div>


	<!-- 노트모달 -->
	<div class="modal fade" id="detailModal1" tabindex="-1" role="dialog">
		<div class="modal-dialog modal-lg">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal">
						<span aria-hidden="true">&times;</span><span class="sr-only">Close</span>
					</button>
					<div id='title1' class="w3-margin w3-padding modal_detail_title"></div>
				</div>
				<div class="modal-body">
					<div class="row">
						<div class="col-md-12">
							<div id='date1' class="w3-margin w3-padding modal_detail_date"></div>
							<div id='content1' class="w3-margin w3-padding modal_detail_content"></div>
						</div>
					</div>
				</div>
				<div class="modal-footer">
					<span id='update1' class="w3-margin w3-padding modal_detail_footer"> </span>
				</div>
			</div>
		</div>
	</div>
	
	
	
	
	
	
	
	
<script>


var test = null;
var dragged = null; // A reference to the element currently being dragged
// highlight stationary nodes during an external drag-and-drop into a Diagram
function highlight(node) {  // may be null
  var oldskips = myDiagram.skipsUndoManager;
  myDiagram.skipsUndoManager = true;
  myDiagram.startTransaction("highlight");
  if (node !== null) {
    myDiagram.highlight(node);
  } else {
    myDiagram.clearHighlighteds();
  }
  myDiagram.commitTransaction("highlight");
  myDiagram.skipsUndoManager = oldskips;
}

// This event should only fire on the drag targets.
// Instead of finding every drag target,
// we can add the event to the document and disregard
// all elements that are not of class "draggable"
document.addEventListener("dragstart", function(event) {
  if (event.target.className !== "gallery") return;
  // Some data must be set to allow drag
  event.dataTransfer.setData("text", "");
  event.dataTransfer.setData("img", "");
  // store a reference to the dragged element
  dragged = event.target;
  // Objects during drag will have a red border
  event.target.style.border = "2px solid red";
}, false);

// This event resets styles after a drag has completed (successfully or not)
document.addEventListener("dragend", function(event) {
  // reset the border of the dragged element
  dragged.style.border = "";
  highlight(null);
}, false);

// Next, events intended for the drop target - the Diagram div

var div = document.getElementById("myDiagramDiv");
div.addEventListener("dragenter", function(event) {
  // Here you could also set effects on the Diagram,
  // such as changing the background color to indicate an acceptable drop zone

  // Requirement in some browsers, such as Internet Explorer
  event.preventDefault();
}, false);

div.addEventListener("dragover", function(event) {
  // We call preventDefault to allow a drop
  // But on divs that already contain an element,
  // we want to disallow dropping

  if (this === myDiagram.div) {
    var can = event.target;
    var pixelratio = window.PIXELRATIO;

    // if the target is not the canvas, we may have trouble, so just quit:
    if (!(can instanceof HTMLCanvasElement)) return;

    var bbox = can.getBoundingClientRect();
    var bbw = bbox.width;
    if (bbw === 0) bbw = 0.001;
    var bbh = bbox.height;
    if (bbh === 0) bbh = 0.001;
    var mx = event.clientX - bbox.left * ((can.width / pixelratio) / bbw);
    var my = event.clientY - bbox.top * ((can.height / pixelratio) / bbh);
    var point = myDiagram.transformViewToDoc(new go.Point(mx, my));
    var curnode = myDiagram.findPartAt(point, true);
    if (curnode instanceof go.Node) {
      highlight(curnode);
    } else {
      highlight(null);
    }
  }

  if (event.target.className === "dropzone") {
    // Disallow a drop by returning before a call to preventDefault:
    return;
  }

  // Allow a drop on everything else
  event.preventDefault();
}, false);

div.addEventListener("dragleave", function(event) {
  // reset background of potential drop target
  if (event.target.className == "dropzone") {
    event.target.style.background = "";
  }
  highlight(null);
}, false);

// handle the user option for removing dragged items from the Palette
var remove = document.getElementById('remove');

div.addEventListener("drop", function(event) {
  // prevent default action
  // (open as link for some elements in some browsers)
  event.preventDefault();

  // Dragging onto a Diagram
  if (this === myDiagram.div) {
    var can = event.target;
    var pixelratio = window.PIXELRATIO;

    // if the target is not the canvas, we may have trouble, so just quit:
    if (!(can instanceof HTMLCanvasElement)) return;

    var bbox = can.getBoundingClientRect();
    var bbw = bbox.width;
    if (bbw === 0) bbw = 0.001;
    var bbh = bbox.height;
    if (bbh === 0) bbh = 0.001;
    var mx = event.clientX - bbox.left * ((can.width/pixelratio) / bbw);
    var my = event.clientY - bbox.top * ((can.height/pixelratio) / bbh);
    var point = myDiagram.transformViewToDoc(new go.Point(mx, my));
    myDiagram.startTransaction('new node');
   	test = dragged.innerHTML;
   	var pattern = "<img\\s+([a-zA-Z0-9]+\\s*=\\s*\"?.*?)?\\s*src\\s*=\\s*\"?(.*?)[\"|>]";
   	var imgsrc = test.match(pattern);
   	console.log(imgsrc[2]);
    myDiagram.model.addNodeData({
      location: point,
      text: dragged.textContent,
      img: imgsrc[2],
      
      color: "lightyellow"
    });
    myDiagram.commitTransaction('new node');

    // remove dragged element from its old location
  }

  // If we were using drag data, we could get it here, ie:
  // var data = event.dataTransfer.getData('text');
}, false);

// *********************************************************
// Second, set up a GoJS Diagram
// *********************************************************

var a = go.GraphObject.make;  // for conciseness in defining templates

myDiagram = a(go.Diagram, "myDiagramDiv",  // create a Diagram for the DIV HTML element
              {
                initialContentAlignment: go.Spot.Center,
                "toolManager.mouseWheelBehavior": go.ToolManager.WheelZoom,
                "commandHandler.archetypeGroupData": { text: "Group", isGroup: true, color: "blue" },
                "undoManager.isEnabled": true,
              
              });
window.PIXELRATIO = myDiagram.computePixelRatio(); // constant needed to determine mouse coordinates on the canvas

myDiagram.nodeTemplate =
    a(go.Node, "Vertical",
       { locationSpot: go.Spot.Center }, 
      new go.Binding('location'),//.makeTwoWay(go.Point.stringify),
       
      /* a(go.Shape, "RoundedRectangle",
        {
          fill: "white", // the default fill, if there is no data bound value
          portId: "", cursor: "pointer",  // the Shape is the port, not the whole Node
          // allow all kinds of links from and to this port
          fromLinkable: true, fromLinkableSelfNode: true, fromLinkableDuplicates: true,
          toLinkable: true, toLinkableSelfNode: true, toLinkableDuplicates: true
        }, 
        new go.Binding("fill", "color")),  */
        
        
        
        a(go.Picture,
      	        { maxSize: new go.Size(100, 100),portId: "", cursor: "pointer",  // the Shape is the port, not the whole Node
            // allow all kinds of links from and to this port
             
            
            fromLinkable: true, fromLinkableSelfNode: true, fromLinkableDuplicates: true,
            toLinkable: true, toLinkableDuplicates: true },
      	        new go.Binding("source", "img")
        ),
        
        
        
      a(go.TextBlock,
        {
          font: "bold 14px sans-serif",
          stroke: '#333',
          margin:10,  // make some extra space for the shape around the text
          isMultiline: false,  // don't allow newlines in text
          editable: true,
          // allow in-place editing by user
        },
                    
              
        new go.Binding("text","text").makeTwoWay()),  // the label shows the node data's text
        
      { // this tooltip Adornment is shared by all nodes
        toolTip:
          a(go.Adornment, "Auto",
            a(go.Shape, { fill: "#FFFFCC" }),
            a(go.TextBlock, { margin: 4 },  // the tooltip shows the result of calling nodeInfo(data)
              new go.Binding("text", "", nodeInfo))
          ),
        // this context menu Adornment is shared by all nodes
        contextMenu: partContextMenu
      }
    ); 




function makeButton(text, action, visiblePredicate) {
    return a("ContextMenuButton",
             a(go.TextBlock, text),
             { click: action },
             // don't bother with binding GraphObject.visible if there's no predicate
             visiblePredicate ? new go.Binding("visible", "", function(o, e) { return o.diagram ? visiblePredicate(o, e) : false; }).ofObject() : {});
  }





var partContextMenu =
    a(go.Adornment, "Vertical",
        makeButton("Properties",
                   function(e, obj) {  // OBJ is this Button
                     var contextmenu = obj.part;  // the Button is in the context menu Adornment
                     var part = contextmenu.adornedPart;  // the adornedPart is the Part that the context menu adorns
                     // now can do something with PART, or with its data, or with the Adornment (the context menu)
                     if (part instanceof go.Link) alert(linkInfo(part.data));
                     else if (part instanceof go.Group) alert(groupInfo(contextmenu));
                     else alert(nodeInfo(part.data));
                   }),
        makeButton("Cut",
                   function(e, obj) { e.diagram.commandHandler.cutSelection(); },
                   function(o) { return o.diagram.commandHandler.canCutSelection(); }),
        makeButton("Copy",
                   function(e, obj) { e.diagram.commandHandler.copySelection(); },
                   function(o) { return o.diagram.commandHandler.canCopySelection(); }),
        makeButton("Paste",
                   function(e, obj) { e.diagram.commandHandler.pasteSelection(e.diagram.lastInput.documentPoint); },
                   function(o) { return o.diagram.commandHandler.canPasteSelection(); }),
        makeButton("Delete",
                   function(e, obj) { e.diagram.commandHandler.deleteSelection(); },
                   function(o) { return o.diagram.commandHandler.canDeleteSelection(); }),
        makeButton("Undo",
                   function(e, obj) { e.diagram.commandHandler.undo(); },
                   function(o) { return o.diagram.commandHandler.canUndo(); }),
        makeButton("Redo",
                   function(e, obj) { e.diagram.commandHandler.redo(); },
                   function(o) { return o.diagram.commandHandler.canRedo(); }),
        makeButton("Group",
                   function(e, obj) { e.diagram.commandHandler.groupSelection(); },
                   function(o) { return o.diagram.commandHandler.canGroupSelection(); }),
        makeButton("Ungroup",
                   function(e, obj) { e.diagram.commandHandler.ungroupSelection(); },
                   function(o) { return o.diagram.commandHandler.canUngroupSelection(); })
    );


function nodeInfo(d) {  // Tooltip info for a node data object
    var str = "Node " + d.key + ": " + d.text + "\n";
    if (d.group)
      str += "member of " + d.group;
    else
      str += "top-level node";
    return str;
  }

  // These nodes have text surrounded by a rounded rectangle
  // whose fill color is bound to the node data.
  // The user can drag a node by dragging its TextBlock label.
  // Dragging from the Shape will start drawing a new link.
  

  // Define the appearance and behavior for Links:

  function linkInfo(d) {  // Tooltip info for a link data object
    return "Link:\nfrom " + d.from + " to " + d.to;
  }

  // The link shape and arrowhead have their stroke brush data bound to the "color" property
  myDiagram.linkTemplate =
    a(go.Link,
      { toShortLength: 3, reshapable: true,relinkableFrom: true, relinkableTo: true },  // allow the user to relink existing links
      new go.Binding("location").makeTwoWay(),

      a(go.Shape,
        { strokeWidth: 2 },
        new go.Binding("stroke", "color")),
      a(go.Shape,
        { toArrow: "Standard", stroke: null },
        new go.Binding("fill", "color")),
        a(go.TextBlock, "연결됨\n",  // the label text
                {
                  textAlign: "center",
                  font: "12pt helvetica, arial, sans-serif",
                  margin: 7,
                  editable: true  // enable in-place editing
                },
                // editing the text automatically updates the model data
                new go.Binding("text").makeTwoWay()),
        
        
      { // this tooltip Adornment is shared by all links
        toolTip:
          a(go.Adornment, "Auto",
            a(go.Shape, { fill: "#FFFFCC" }),
            a(go.TextBlock, { margin: 4 },  // the tooltip shows the result of calling linkInfo(data)
              new go.Binding("text", "", linkInfo))
          ),
        // the same context menu Adornment is shared by all links
        contextMenu: partContextMenu
      }
     
    );

  // Define the appearance and behavior for Groups:

 function groupInfo(adornment) {  // takes the tooltip or context menu, not a group node data object
    var g = adornment.adornedPart;  // get the Group that the tooltip adorns
    var mems = g.memberParts.count;
    var links = 0;
    g.memberParts.each(function(part) {
      if (part instanceof go.Link) links++;
    });
    return "Group " + g.data.key + ": " + g.data.text + "\n" + mems + " members including " + links + " links";
  }

  // Groups consist of a title in the color given by the group node data
  // above a translucent gray rectangle surrounding the member parts
  myDiagram.groupTemplate =
    a(go.Group, "Vertical",
      { selectionObjectName: "PANEL",  // selection handle goes around shape, not label
        ungroupable: true },  // enable Ctrl-Shift-G to ungroup a selected Group
      a(go.TextBlock,
        {
          font: "bold 19px sans-serif",
          isMultiline: false,  // don't allow newlines in text
          editable: true  // allow in-place editing by user
        },
        new go.Binding("text", "text").makeTwoWay(),
        new go.Binding("stroke", "color")),
      a(go.Panel, "Auto",
        { name: "PANEL" },
        a(go.Shape, "Rectangle",  // the rectangular shape around the members
          {
            fill: "rgba(128,128,128,0.2)", stroke: "gray", strokeWidth: 3,
            portId: "", cursor: "pointer",  // the Shape is the port, not the whole Node
            // allow all kinds of links from and to this port
            fromLinkable: true, fromLinkableSelfNode: true, fromLinkableDuplicates: true,
            toLinkable: true, toLinkableSelfNode: true, toLinkableDuplicates: true
          }),
         
        a(go.Placeholder, { margin: 10, background: "transparent" })  // represents where the members are
      ),
      { // this tooltip Adornment is shared by all groups
        toolTip:
          a(go.Adornment, "Auto",
            a(go.Shape, { fill: "#FFFFCC" }),
            a(go.TextBlock, { margin: 4 },
              // bind to tooltip, not to Group.data, to allow access to Group properties
              new go.Binding("text", "", groupInfo).ofObject())
          ),
        // the same context menu Adornment is shared by all groups
        contextMenu: partContextMenu
      }
    );

  // Define the behavior for the Diagram background:

  function diagramInfo(model) {  // Tooltip info for the diagram's model
    return "Model:\n" + model.nodeDataArray.length + " nodes, " + model.linkDataArray.length + " links";
  }

  // provide a tooltip for the background of the Diagram, when not over any Part
  myDiagram.toolTip =
    a(go.Adornment, "Auto",
      a(go.Shape, { fill: "#FFFFCC" }),
      a(go.TextBlock, { margin: 4 },
        new go.Binding("text", "", diagramInfo))
    );

  // provide a context menu for the background of the Diagram, when not over any Part
  myDiagram.contextMenu =
    a(go.Adornment, "Vertical",
        makeButton("Paste",
                   function(e, obj) { e.diagram.commandHandler.pasteSelection(e.diagram.lastInput.documentPoint); },
                   function(o) { return o.diagram.commandHandler.canPasteSelection(); }),
        makeButton("Undo",
                   function(e, obj) { e.diagram.commandHandler.undo(); },
                   function(o) { return o.diagram.commandHandler.canUndo(); }),
        makeButton("Redo",
                   function(e, obj) { e.diagram.commandHandler.redo(); },
                   function(o) { return o.diagram.commandHandler.canRedo(); })
    );

  // Create the Diagram's Model:
  /* var nodeDataArray = [
    { key: 1, text: "Alpha", color: "lightblue" },
    { key: 2, text: "Beta", color: "orange" },
    { key: 3, text: "Gamma", color: "lightgreen", group: 5 },
    { key: 4, text: "Delta", color: "pink", group: 5 },
    { key: 5, text: "Epsilon", color: "green", isGroup: true }
  ];
  var linkDataArray = [
    { from: 1, to: 2, color: "blue" },
    { from: 2, to: 2 },
    { from: 3, to: 4, color: "green" },
    { from: 3, to: 1, color: "purple" }
  ];
  myDiagram.model = new go.GraphLinksModel(nodeDataArray, linkDataArray);
 */











































































function getMainCategory2(){
	var memberNo = localStorage.getItem("memberNo");
	$.ajax({
		type: "POST",
		url : "/memory/note/getCategory",
		data: {"memberNo" : memberNo},
		dataType : "json"
	})
	.done(function (result) {
		var html = '<li class="active"><a data-toggle="tab" onclick="mainNoteList2()">전체</a></li>';
		var categoryList = result.categoryList;
		for(var i = 0; i < categoryList.length; i++){
			var category = categoryList[i];
			var categoryNo = category.categoryNo;
			html += "<li class='active' onclick='getNoteByCategoryNo2("+category.categoryNo+")' ondragstart='drag(event)' draggable='true' id='category"+category.categoryNo+"' aria-expanded='false' class='category_list'>"
			html += "<a data-toggle='tab' ondblclick='categoryUpdate(event);' href='#' ondragstart='drag(event)' draggable='true' id='category"+category.categoryNo+"' style='min-width:20px;'>"+category.categoryName+"</a>";
			html += "<a data-toggle='tab' contenteditable='true' style='min-width:20px; display:none;' id='categoryUpdate"+category.categoryNo+"'>"+category.categoryName+"</a>";
//			html += "<a data-toggle='tab' ondblclick='categoryUpdate(event);' href='#' ondragstart='drag(event)' draggable='true' id='category"+category.categoryNo+"' class='category_list'>"+category.categoryName+"</a>";
//			html += "<a data-toggle='tab' contenteditable='true' class='category_list_2' id='categoryUpdate"+category.categoryNo+"'>"+category.categoryName+"</a>";
			html += "</li>";
		}
		$("#categoryList2").html(html);
	})
	.fail(function(jqXhr, textStatus, errorText){
		alert("오류: " + errorText + "<br>" + "오류코드: " + status);
	});
}


function mainNoteList2() {
	var memberNo = localStorage.getItem("memberNo");
	$.ajax({
		type: "POST",
		url : "/memory/note/noteList",
		data: {"memberNo" : memberNo},
		dataType : "json"
	})
	.done(function (result) {
		makeNoteCards2(result);
	})
	.fail(function(jqXhr, textStatus, errorText){
		alert("오류: " + errorText + "<br>" + "오류코드: " + status);
	});
}

/* function makeNoteCards2(result) {
	var html = "";
	for (var i = 0; i < result.length; i++) {

		var note = result[i];	
		var noteNo = note.noteNo;
		var categoryNo = note.categoryNo;
		html += "<div class='gallery' onclick='noteDetail2("+note.noteNo+")' class='modal_input' ondragstart='drag(event)' draggable='true' id='note"+note.noteNo+"' data-toggle='modal' data-target='#detailModal1'  >";
		// 이미지 뿌리기
		var noteContent = note.noteContent;
		if(noteContent.indexOf('<img') != -1) {
			var noteImgSrc = noteContent.split('src="')[1].split('"')[0];
			html += '<figure><img id="note'+note.noteNo+'" src="' + noteImgSrc + '" alt="" onclick="noteDetail2('+note.noteNo+')" ></figure>';
		} else {
			html += '<figure><img id="note'+note.noteNo+'" src="/memory/resources/img/D.png" width="180" height="140" alt="" onclick="noteDetail2('+note.noteNo+')" ></figure>';
		}
		html += "<div class='desc'><p>" + note.noteTitle + "</p></div>";
		html += "</div>";

	}
	if (result.length == 0) {
		html += "<div class='gallery'>";
		html += '	<img src="/memory/resources/img/D.png" alt="" width="300px" height="200px" >';
		html += "	<div  class='desc'><p> 노트가 없습니다. </p></div>";
		html += "</div>";
	}
	$("#mindCardList").html(html);
}
 */

function makeNoteCards2(result) {
	var html = "";
	for (var i = 0; i < result.length; i++) {

		var note = result[i];	
		var noteNo = note.noteNo;
		var categoryNo = note.categoryNo;
		html += "<div class='gallery' onclick='noteDetail2("+note.noteNo+")' ondragstart='drag(event)' draggable='true' id='note"+note.noteNo+"' data-toggle='modal' data-target='#detailModal1'>";
		// 이미지 뿌리기
		var noteContent = note.noteContent;
		if(noteContent.indexOf('<img') != -1) {
			var noteImgSrc = noteContent.split('src="')[1].split('"')[0];
			html += '<figure><img class="gallery" id="note'+note.noteNo+'" src="' + noteImgSrc + '" draggable="true" alt="" onclick="noteDetail2('+note.noteNo+')" ></figure>';
		} else {
			html += '<figure><img id="note'+note.noteNo+'" src="/memory/resources/img/D.png" width="180" height="140" alt="" onclick="noteDetail2('+note.noteNo+')" ></figure>';
		}
		html += "<div class='desc'><p>" + note.noteTitle + "</p></div>";
		html += "</div>";

	}
	if (result.length == 0) {
		html += "<div class='gallery'>";
		html += '	<img src="/memory/resources/img/D.png" alt="" width="300px" height="200px" >';
		html += "	<div  class='desc'><p> 노트가 없습니다. </p></div>";
		html += "하이하이";
		html += "</div>";
	}
	$("#mindCardList").html(html);
}

 
 
 
 
 
 


//노트 디테일
function noteDetail2(noteNo){
	$.ajax({
		type: "POST",
		url : "/memory/note/noteDetail",
		data: {"noteNo" : noteNo},
		dataType : "json"
	})
	.done(function (result) {
		var title = result.noteTitle;
		var content = result.noteContent;
		// 시간 뿌리기
		var date = new Date(result.noteRegDate);
		var time = date.getFullYear() + "-" 
		         + (date.getMonth() + 1) + "-" 
		         + date.getDate() + " "
		         + date.getHours() + ":"
		         + date.getMinutes() + ":"
		         + date.getSeconds();
		//시간 뿌리기 끝
		$("#title1").html("<span>[ "+ result.categoryName +" ]</span><h3>" + title +"</h3>");
		$("#date1").html(time);
		$("#content1").html(content);
		
	})
	.fail(function(jqXhr, textStatus, errorText){
		alert("오류: " + errorText + "<br>" + "오류코드: " + status);
	});
}

function getNoteByCategoryNo2(categoryNo){
	var categoryNo = categoryNo;
	var memberNo = localStorage.getItem("memberNo");
	$.ajax({
		type: "POST",
		url : "/memory/note/noteCartegoryList",
		data: {"memberNo" : memberNo,
			   "categoryNo" : categoryNo		
		},
		dataType : "json"
	})
	.done(function (result) {
		makeNoteCards2(result);
	})
	.fail(function(jqXhr, textStatus, errorText){
		alert("오류: " + errorText + "<br>" + "오류코드: " + status);
	});
}

function searchList2(){
	var searchWrd = $("#searchWrd2").val();
	var memberNo = localStorage.getItem("memberNo");
	$.ajax({
		type: "POST",
		url : "/memory/note/noteList",
		data: {"searchWrd" : searchWrd,
			   "memberNo" : memberNo
		 	},
		dataType : "json"
	})
	.done(function (result) {
		makeNoteCards2(result);
		$("#searchWrd2").val("");
		return false;
	})
	.fail(function(jqXhr, textStatus, errorText){
		alert("오류: " + errorText + "<br>" + "오류코드: " + status);
	});
	
}


function save() {
	 
	var mindjson =   myDiagram.model.toJson();
	var mem_no = ${memberNo};
	var sessionnum = sessionStorage.getItem("num");
	
	console.log(mem_no);	
	console.log(sessionnum+"세션넘버");
	if(sessionnum == null){
		var mindname = prompt('마인드맵 제목을 입력해 주세요', '');
		if(mindname == null){
			return;
		}
		$.ajax({
			type:"POST",
			url: "/memory/mindmap/save",
			data: {'mindjson': mindjson,
					'mindname': mindname,
					'mem_no': mem_no
				},
			success: function(result){
				if(result == "true"){
					alert("마인드맵이 저장되었습니다.");
					load();
				}else{
					alert("실패");
				}
				
			},
			error: function(jqXhr, textStatus, errorText) {
				alert("오류: " + errorText + "<br>" + "오류코드: " + status);
			}
		});
		
	}else{
		$.ajax({
			type:"POST",
			url: "/memory/mindmap/modify",
			data: {'mindjson': mindjson,
					'mindnum': sessionnum
				},
			success: function(result){
				if(result == "true"){
					alert("마인드맵이 수정되었습니다.");
					load();
				}else{
					alert("실패");
				}
				
			},
			error: function(jqXhr, textStatus, errorText) {
				alert("오류: " + errorText + "<br>" + "오류코드: " + status);
			}
		});
	}
	
	
	 
	
  }

function load() {
	var mem_no = ${memberNo};
	
	$.ajax({
		type:"POST",
		url: "/memory/mindmap/load",
		data: {
			
			'mem_no': mem_no
		},
		
		success: function(result){
			makeMindmapList(result);
			},
		error: function(jqXhr, textStatus, errorText) {
			alert("오류: " + errorText + "<br>" + "오류코드: " + status);
		}
	});
}


 function makeMindmapList(result){
	 var html = "";
	 if(result.length != 0){
	 for (var i = 0; i < result.length; i++) {

			var map = result[i];
			var mindnum = map.mindnum;
			var mindname = map.mindname;
			var mindcontent = map.mindjson;
			//html += "<div class='loadmind' onclick='loadmindmap("+mindnum+")'>";
		
			html += "<div class='loaded'><li onclick='loadmindmap("+mindcontent+","+mindnum+")'>" + mindname + "</li></div>";
			
			//html += "</div>";

		}
	 }else{
			html += "<div class='nomind'>";
			html += "	<div  class='no'><p> 마인드맵이 없습니다. </p></div>";
			html += "</div>";
		}
		$("#loadedjson").html(html);
 
 }

 function loadmindmap(mindcontent,mindnum){
	 myDiagram.model = go.Model.fromJson(mindcontent);
	 sessionStorage.setItem("num", mindnum);
	 console.log(sessionStorage.getItem("num")+"세션입니당");
 }
 
function deletemap(){
	var mindn = sessionStorage.getItem("num");
	console.log(mindn);
	
	$.ajax({
		type:"POST",
		url: "/memory/mindmap/delete",
		data: {
			
			'mindnum': mindn
		},
		
		success: function(result){
			if(result){
				alert("삭제되었습니다.");
				myDiagram.clear();
				load();
			}else{
				alert("삭제오류");
			}
			},
		error: function(jqXhr, textStatus, errorText) {
			alert("오류: " + errorText + "<br>" + "오류코드: " + status);
		}
	});
	
	sessionStorage.clear();
	
	load();
	
}
 
 
 
 function newmap(){
	 myDiagram.clear();
	 sessionStorage.clear();
	 
 }
 
 
</script>





</body>
</html>