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
<script src="/memory/resources/js/go-debug.js"></script>
<script src="/memory/resources/js/go.js"></script>
</head>
<body>
	<!-- title -->
	<div id = "container">
	<div class="container show-grid" id="sample" style="padding-top: 17px;">
		<p class="pageTitle">다이어그램</p>
		<p class="pageSubTitle">자신의 계획을 표현해보세요</p>
	</div>
	
	<!-- 메뉴부분 -->
	<div class="mindMenu divCenter" id="mindMenu">
		
			
				<div class="notelist">
					
					<div class="selects">
			        	<form name="categorySel">
							<select class="form-control" id="cateSel" onchange="cateSelect()">
								<option selected>전체보기</option>
							</select>
						</form>
					</div>
					<div class="tab-content"><br>
						<div id="mindCardList" class="mindCardList List">
						</div>
					</div>
				</div>
		
	</div>
	
		
	<!-- 마인드맵 dropZone -->
	<div id="mindtitle">
		<!-- <input id="tit" placehold="여기에 제목을 입력해 주세요"></input> -->
	</div>
	<div class="dropzone" id="myDiagramDiv">
	</div>
	<div id="co">
	
	
		        		<p id = "tool">TOOL BOX</p>
					
	<table id="toolbox">
	<br>
	<br>
	<br>
	
	<tr>
	<button class="btn btn-default btn-block btn-lg" id="NewButton" onclick="Newmap()">Newmap</button>
	</tr>
	<br>
	<br>
	<br>
	<tr>
			<button class="btn btn-default btn-block btn-lg btn-success"  id="SaveButton" onclick="save()">Save</button>
		</tr>
		
	<br>	
	<br>	
	<br>	
	<tr>		
			<button data-toggle="modal" data-target="#myModal"   class="btn btn-default btn-block btn-lg btn-primary"   id="LoadButton" onclick="load()">Load</button>
	</tr>
	<br>
	<br>
	<br>
	<tr> <!-- 저장목록 -->
			<button class="btn btn-default btn-block btn-lg btn-danger"  id="DeleteButton" onclick="deletemap()">Delete</button>
			</tr>
			 </table>	
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
	
	
	<!-- 로드모달 -->
	
	 <div class="modal fade" id="myModal" role="dialog">
		    <div class="modal-dialog">
		    
		      Modal content
		      <div class="modal-content memberLogin">
		        <div class="modal-header">
		          <button type="button" class="close" id="modalClose" data-dismiss="modal">&times;</button>
		          <br>
		          <br>
		          <h4 class="modal-title loginTitle" id="memoryLaneTitle">보고싶은 마인드맵</h4>
		          <br>
		        </div>
		        <br>
		        
		        
		        <div id="loadedjson"></div>
		        	<!-- <div class="modal-body joinModal" id="joinModal">
		          	<form name="joinfrm" id="joinfrm">       
			    	<div id="joinInfo">
			    			<div class="form-group">
			    			 <label for="name">name:</label>
			    			 <input type="text" class="form-control" id="name" name="name" placeholder="이름을 입력하세요" required="" autofocus="" />
			    			</div>
			    			<div class="form-group">
			    			 <label for="email">Email:</label>
			    			 <input type="email" class="form-control" id="email" name="email" placeholder="이메일을 입력하세요" required="" autofocus="" />
			    			 <span id="emailck"></span>
			    			</div>
			    			<div class="form-group">
			    			 <label for="password">password:</label>
			    			 <input type="password" class="form-control" id="password" name="password" placeholder="비밀번호를 입력하세요" required="" autofocus="" />
			    			</div>
			    			<div class="form-group">
			    			 <label for="passwordConf">password check:</label>
			    			 <input type="password" class="form-control" id="passwordConf" name="passwordConf" placeholder="비밀번호를 확인하세요" required="" autofocus="" />
			    			 <span id="checkPwd"></span>
			    			</div>
			    		</div>
			    		<table>
			    		<tr>
			    			<td colspan="2">&nbsp;&nbsp;</td>
			    		</tr>
						</table>
						<table class="btns_align">
			    			<td id="btns btn_space">
							    <button id="joinBtn" class="btn btn-default join_ok join_btns">회원가입</button>   
							    <button id="cancelBtn" class="btn btn-default join_no join_btns">취소</button>  
			    			</td>
			    		</tr>
		    		</table>
			    </form>
		        	</div> -->
		      <!--   	
		        <div class="modal-body" id="loginModal" >
		          	
		          	
		          	<form name="loginfrm" id="loginfrm">       
			    	<table id="loginInfo">
			    		<tr>
			    			<div class="form-group">
			    			 <label for="loginEmail">Email:</label>
			    			 <input type="text" class="form-control" id="loginEmail" name="loginEmail" placeholder="Email Address" required="" autofocus="" />
			    			</div>
			    		</tr>
			    		<tr>
			    			<div class="form-group">
							    <label for="loginPassword">Password:</label>
							    <input type="password" class="form-control" id="loginPassword" name="loginPassword" placeholder="Password" required=""/>
			    			</div>
			    		</tr>
			    	</table>
			    	<table class="btns_align">
					    <tr>
					    	<td id="btns btn_etc btn_space">
							    <button id="loginBtn" class="btn btn-default login_ok">로그인</button>   
							    <div id="joinFormBtn" class="btn btn-default login_no">회원가입</div>
					    	</td>
					    </tr>
		    		</table>
			    </form>
		          <div id="googleLoginDiv" align="center" class="g-signin2 googleLogin" data-onsuccess="onSignIn"></div>
		          
		        </div> -->
		      </div>
	
	</div>
	
	
	
	
	
	
	</div> 
	</div> <!-- 컨테이너 절대 지우지 말것 -->
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
  if (event.target.className !== "gallery_mind") return;
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
          font: "bold 25px sans-serif",
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
     /*  a(go.Shape,
        { toArrow: "Standard", stroke: null },
        new go.Binding("fill", "color")), */
        a(go.TextBlock, "연결됨\n",  // the label text
                {
                  textAlign: "center",
                  font: "20pt helvetica, arial, sans-serif",
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
		var html = "<option value='allCategory'>전체글 보기</option>";
		var categoryList = result.categoryList;
		for(var i = 0; i < categoryList.length; i++){
			var category = categoryList[i];
			var categoryNo = category.categoryNo;
			html += "<option value='"+category.categoryNo+"'>"+category.categoryName+"</option>"
		}
		$("#cateSel").html(html);
	})
	.fail(function(jqXhr, textStatus, errorText){
		alert("오류: " + errorText + "<br>" + "오류코드: " + status);
	});
}
 
 
function cateSelect() {
	  var categoryNo=document.getElementById("cateSel").value
	  getNoteByCategoryNo2(categoryNo);
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
		swal({
			  title: 'Error!',
			  text: '노트목록 로딩을 실패했습니다.',
			  type: 'error',
			  confirmButtonText: '확인'
			})
	});
}


function makeNoteCards2(result) {
	var html = "";
	for (var i = 0; i < result.length; i++) {

		var note = result[i];	
		var noteNo = note.noteNo;
		var categoryNo = note.categoryNo;
		html += "<div class='gallery_mind' onclick='noteDetail2("+note.noteNo+")' ondragstart='drag(event)' draggable='true' id='note"+note.noteNo+"' data-toggle='modal' data-target='#detailModal1'>";
		// 이미지 뿌리기
		var noteContent = note.noteContent;
		if(noteContent.indexOf('<img') != -1) {
			var noteImgSrc = noteContent.split('src="')[1].split('"')[0];
			html += '<figure><img  id="note'+note.noteNo+'" src="' + noteImgSrc + '" alt="" width="270px" height="150px"draggable="true" alt="" onclick="noteDetail2('+note.noteNo+')" ></figure>';
		} else {
			html += '<figure><img id="note'+note.noteNo+'" src="/memory/resources/img/D.png" width="160" height="120" alt="" onclick="noteDetail2('+note.noteNo+')" ></figure>';
		}
		html += "<div class='desc'><p>" + note.noteTitle + "</p></div>";
		html += "</div>";

	}
	if (result.length == 0) {
		html += "<div class='gallery_mind'>";
		html += '	<img src="/memory/resources/img/D.png" alt="" width="270px" height="150px" >';
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
	if(categoryNo != "allCategory") {
	$.ajax({
		type: "POST",
		url : "/memory/note/noteCategoryList",
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
	} else {
		mainNoteList2();
	}
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
	console.log(mem_no+"로드")
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
			var md = map.mindname;
			console.log(md+"1");
			var mindcontent = map.mindjson;
			//html += "<div class='loadmind' onclick='loadmindmap("+mindnum+")'>";
		
			html += "<botton class='btn btn-default btn-block' data-dismiss='modal' onclick='loadmindmap("+mindcontent+","+mindnum+")'>"+md+"</botton>";
			
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
 
	/*  console.log("하이하이");
	  var htmll = "";
	  var mindcontent = mindcontent;
	  console.log(mindcontent);
	  var mindnum = mindnum;
	  var md = md;
	  console.log(md + "맵이름");
	 htmll = "<input id='tit'>"+md+"</input>";
	 
	 $("#mindtitle").html(htmll);  */
	 
 }
 
function deletemap(){
	var mindn = sessionStorage.getItem("num");
	console.log(mindn);
	if(mindn == null){
		alert("삭제할 마인드맵이 없습니다.");
		return;
	}else{
		var re = confirm("삭제하시겠습니까?");
		if(re == true){
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
						sessionStorage.clear();
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
			
			
			
		}else{
			
			return;
		}
		
		
	}
	
		
	
}
 
 
 
 function Newmap(){
	 myDiagram.clear();
	 sessionStorage.clear();
	 
 }
 
</script>
</body>
</html>