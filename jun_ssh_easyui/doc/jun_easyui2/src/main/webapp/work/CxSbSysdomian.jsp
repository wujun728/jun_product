<%@page contentType="text/html;charset=UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<%@ include file="/include/taglibs.jsp" %>
<%@ include file="/include/meta.jsp" %>
<script id="pjs" type="text/javascript" src="${ctx}/js/page/CxSbSysdomian.js"></script>
<script>
var cxSbSysdomianId="i_sy_cxSbSysdomian_datagrid";
var cxSbSysdomianDt,cxSbSysdomianUploadDg,cxSbSysdomianUploadFm;
var columns= [ [
            	 {
            		field : 'id',
            		checkbox:false, 
            		addform:{type:'eType.Input', hidden:true}, 
            		editform:{type:'eType.Input', hidden:true}, 
            		title:'序号', 
            		width : '150'
            	  }, 
            	 {
            		field : 'tableName',
            		title:'表名', 
            		addform:{type:'eType.Input', hidden:false}, 
            		editform:{type:'eType.Input', hidden:false}, 
            		width : '150'
            	  }, 
            	 {
            		field : 'fieldName',
            		checkbox:false, 
            		addform:{type:'eType.Input', hidden:false}, 
            		editform:{type:'eType.Input', hidden:false}, 
            		title:'字段', 
            		width : '150'
            	  }, 
            	 {
            		field : 'fieldValue',
            		checkbox:false, 
            		addform:{type:'eType.Input', hidden:false}, 
            		editform:{type:'eType.Input', hidden:false}, 
            		title:'值', 
            		width : '150'
            	  }, 
            	 {
            		field : 'fieldDesc',
            		checkbox:false, 
            		addform:{type:'eType.Input', hidden:false}, 
            		editform:{type:'eType.Input', hidden:false}, 
            		title:'描述/解释', 
            		width : '150'
            	  }, 
            	 {
            		field : 'note',
            		checkbox:false, 
            		addform:{type:'eType.Input', hidden:false}, 
            		editform:{type:'eType.Input', hidden:false}, 
            		title:'备注', 
            		width : '150'
            	  } 
            	] ];
$(function(){
	$('#i_sy_cxSbSysdomian_datagrid_add_dialog').dialog({
		onOpen:function(){
			cxSbSysdomianAddOnOpen();
		}
	});
	
	$('#i_sy_cxSbSysdomian_datagrid_edit_dialog').dialog({
		onOpen:function(){
			cxSbSysdomianEditOnOpen();
		}
	});
	pageView(cxSbSysdomianId,columns);
	cxSbSysdomianonload();
});

function updateFun(d){
	
}

//模式add
function pageView_add(){
	$('#'+cxSbSysdomianId+'_add_dialog').dialog({
		noheader:true,
		fit:true,
		border:false,
		title:null,
		modal: true  
	});
	$('#'+cxSbSysdomianId+'_add_btn a').off().click(function(){
		if(!AddBtnClick()) return;
		var setData={};
		for(var i=0; i<columns[0].length; i++){
			var field=columns[0][i].field;
			var title=columns[0][i].title;
			if(!checkFormField('#'+cxSbSysdomianId+'_add_form_'+field)){log('['+title+']不能为空，请填写!'); return;}
			setData['cxSbSysdomian'+"."+field]=eGet('#'+cxSbSysdomianId+'_add_form_'+field);
		}
		data(getUrl('cxSbSysdomian','Add'),setData,'json',null);
	});
	$('#'+cxSbSysdomianId+'_add_dialog').dialog('open');
}

//模式edit
function pageView_edit(){
	data_={id:$.getUrlParam('id')};
	$.ajax({
		url : getUrl('cxSbSysdomian','Get_ById'),
		data : data_,
		dataType : 'json',
		type: "post", 
		async:true,
		contentType: "application/x-www-form-urlencoded; charset=utf-8", 
		success : function(r) {
			setForm(r,cxSbSysdomianId);
			if(r){if('info' in r){log(r.info);}};
		}
	});
	$('#'+cxSbSysdomianId+'_edit_dialog').dialog({
		noheader:true,
		fit:true,
		border:false,
		title:null,
		modal: true  
	});
	$('#'+cxSbSysdomianId+'_edit_btn a').off().click(function(){
		if(!EditBtnClick()) return;
		var setData={};
		for(var i=0; i<columns[0].length; i++){
			var field=columns[0][i].field;
			var title=columns[0][i].title;
			if(!checkFormField('#'+cxSbSysdomianId+'_edit_form_'+field)){log('['+title+']不能为空，请填写!'); return;}
			setData['cxSbSysdomian'+"."+field]=eGet('#'+cxSbSysdomianId+'_edit_form_'+field);
		}
		data(getUrl('cxSbSysdomian','Update'),setData,'json',null);
	});
	$('#'+cxSbSysdomianId+'_edit_dialog').dialog('open');
}

//模式list
function pageView_list(){
	var cxSbSysdomianDataGrid = {
			id:cxSbSysdomianId,
			url:'${ctx}'+actionUrl('/sys/','cxSbSysdomian','List'),
			dId:'id',
			columns:columns
	};
	
	cxSbSysdomianUploadDg = $('#i_sy_cxSbSysdomian_datagrid_upload_dialog');
	cxSbSysdomianUploadFm =$('#i_sy_cxSbSysdomian_datagrid_upload_dialog_form');
	cxSbSysdomianUploadFm.attr('action','${ctx}'+actionUrl('/sys/','cxSbSysdomian','Upload'));
	
	cxSbSysdomianDt=gGrid2(cxSbSysdomianDataGrid);	
	var straddfun="dorow(cxSbSysdomianId,'','${ctx}"+actionUrl('/sys/','cxSbSysdomian','Add')+"',updateFun,'c')";
	gDataGridToolbarBtn(cxSbSysdomianId,'icon-add',straddfun,"新增");
	var stredit="dorow(cxSbSysdomianId,'','${ctx}"+actionUrl('/sys/','cxSbSysdomian','Update')+"',updateFun,'u')";
	gDataGridToolbarBtn(cxSbSysdomianId,'icon-edit',stredit,"修改");
	var strdelfun="dorow(cxSbSysdomianId,'您是否确定要删除选择的数据','${ctx}"+actionUrl('/sys/','cxSbSysdomian','Delete')+"',updateFun,'d')";
	gDataGridToolbarBtn(cxSbSysdomianId,'icon-remove',strdelfun,"删除");
	var strexcelfun="dorow(cxSbSysdomianId,'您确定要导出数据','${ctx}"+actionUrl('/sys/','cxSbSysdomian','Excel')+"',updateFun,'e')";
	gDataGridToolbarBtn(cxSbSysdomianId,'icon-page_white_excel',strexcelfun,"导出");
	gDataGridToolbarBtn(cxSbSysdomianId,'icon-page_white_excel','upLoadFun()',"导入");
	gDataGridToolbarBtn(cxSbSysdomianId,'icon-page_find','doroodo_search()',"复合查询");
}

function doroodo_search(){
	var searchObj=$.window({
		title :'查询构造器',
		url : top.sysPath+'/component/search.jsp?topthemeName='+top.themeName,
		isIframe : true,
		height : 260,
		width : 800,
		winId : 'searchdig'+new Date().getTime(),
		target : 'self',
		maximizable : true,
		buttons : [ {
			text : '查询',
			handler : function() {
				var obj = searchObj.find('iframe')[0].contentWindow;
				cxSbSysdomianDt.datagrid('load', obj.getSearchs('cxSbSysdomian'));
				searchObj.window('destroy');
			}
		},{
			text : '取消',
			handler : function() {
				searchObj.window('destroy');
			}
		}],
		onComplete: function() {
			var obj = searchObj.find('iframe')[0].contentWindow;
			obj.setSearchColumns(columns);
		}
    });
}
function upLoadFun(){
	cxSbSysdomianUploadDg.dialog('open');
}

function submitUploadForm(){
	cxSbSysdomianUploadFm.form('submit',{
		success:function(d){
			cxSbSysdomianDt.datagrid('reload');
			cxSbSysdomianUploadDg.dialog('close');
			d=$.parseJSON(d);
			log(d.info);
			}
	});
}

function getEditFormHtml(title,type){
	var form=$('#report').clone();
	var word=$('table',form);
	title=title+"详细资料";
	$('td', word).each(function() {
		var gobj = $(this);
		gobj.children().each(function(i,n){
			 var obj = $(n);
		     if(!obj.is('a')){
		    	var id=obj.attr('id');
		    	if(id){
		    		gobj.html(eGet('#'+id));
		    	}
		     }
		    });
	});
	form.children().each(function(i,n){
   	 $('*',$(n)).each(function(ii,nn){
   		 if($(nn).css("display")=='none'){
   			 $(nn).remove();
   		 }
   	 });
	    });
	$('script',form).remove();
	var setData={'tableHtml':'<div class="titlep">'+title+'</div>'+form.html(),'tableTitle':title};
		data(getUrl('cxSbSysdomian', 'FormFile'),setData,
		'json', function(d){if(type=='word'){
			window.open(top.sysPath+'/report/word.jsp',new Date().getTime());
		}else if(type=='excel'){
			window.open(top.sysPath+'/report/excel.jsp',new Date().getTime());
		}});
	
}
</script>
</head>
<body class="easyui-layout" >
<div id="i_sy_cxSbSysdomian_datagrid_toolbar"
		style="padding: 2px 0">
		<table cellpadding="0" cellspacing="0" style="width: 100%">
			<tr>
				<td style="padding-left: 2px"
					id="i_sy_cxSbSysdomian_datagrid_toolbtn"></td>
				<td style="text-align: right; padding-right: 2px"><input
					class="easyui-searchbox" data-options="prompt:'请输入搜索关键词'"
					style="width: 200px" searcher="dSearch"
					id="i_sy_cxSbSysdomian_datagrid_searchbox"
					pdt="i_sy_cxSbSysdomian_datagrid"></input>
					<div id="i_sy_cxSbSysdomian_datagrid_dSComb"
						style="width: 120px"></div></td>
			</tr>
		</table>
	</div>
 <table  id="i_sy_cxSbSysdomian_datagrid"></table> 
 
 <div id="i_sy_cxSbSysdomian_datagrid_add_dialog"
		class="easyui-dialog"
		data-options="closed:true,modal:true,maximizable:true,resizable:true,title:'新建',buttons:'#i_sy_cxSbSysdomian_datagrid_add_btn'"
		align="right" style="width: 1000px; height: 1000px;">
		<div style="padding: 10px 0 10px 10px">
		<div class="titlep">新建</div>
<!-- 请填入新建表单html  start -->
<form id="i_sy_cxSbSysdomian_datagrid_add_form"><table width="99%" border="1" class="formtable" ><tbody><tr><td class="label" align="right" style="width:15%;">表名</td><td align="left" style="width:85%;"><input id="i_sy_cxSbSysdomian_datagrid_add_form_tableName" type="text" reftype="-1"></td></tr><tr><td class="label" align="right" style="width:15%;">字段</td><td align="left" style="width:85%;"><input id="i_sy_cxSbSysdomian_datagrid_add_form_fieldName" type="text" reftype="-1"></td></tr><tr><td class="label" align="right" style="width:15%;">值</td><td align="left" style="width:85%;"><input id="i_sy_cxSbSysdomian_datagrid_add_form_fieldValue" type="text" reftype="-1"></td></tr><tr><td class="label" align="right" style="width:15%;">描述/解释</td><td align="left" style="width:85%;"><input id="i_sy_cxSbSysdomian_datagrid_add_form_fieldDesc" type="text" reftype="-1"></td></tr><tr><td class="label" align="right" style="width:15%;">备注</td><td align="left" style="width:85%;"><input id="i_sy_cxSbSysdomian_datagrid_add_form_note" type="text" reftype="-1"></td></tr><tr style="display:none;"><td class="label" align="right" style="width:15%;display:none;">序号</td><td align="left" style="width:85%;display:none;"><input id="i_sy_cxSbSysdomian_datagrid_add_form_id" type="text" reftype="-1"></td></tr></tbody></table></form>
<!-- 请填入新建表单html  end -->
</div>
</div>
<div id="i_sy_cxSbSysdomian_datagrid_edit_dialog"
		class="easyui-dialog"
		data-options="closed:true,modal:true,maximizable:true,resizable:true,title:'修改',buttons:'#i_sy_cxSbSysdomian_datagrid_edit_btn',toolbar:[{
				text:'导出',
				iconCls:'icon-page_white_excel',
				handler:function(){
					getEditFormHtml('编辑','excel');//请修改
				}
			},
			{
				text:'导出',
				iconCls:'icon-page_white_word',
				handler:function(){
					getEditFormHtml('编辑','word');//请修改
				}
			}]"
		align="right" style="width: 1000px; height: 1000px;">
		<div style="padding: 10px 0 10px 10px">
		<div class="titlep">编辑</div>
<div id="report">
<!-- 请填入编辑表单html  start -->
<form id="i_sy_cxSbSysdomian_datagrid_edit_form"><table width="99%" border="1" class="formtable" ><tbody><tr><td class="label" align="right" style="width:15%;">表名</td><td align="left" style="width:85%;"><input id="i_sy_cxSbSysdomian_datagrid_edit_form_tableName" type="text" reftype="-1"></td></tr><tr><td class="label" align="right" style="width:15%;">字段</td><td align="left" style="width:85%;"><input id="i_sy_cxSbSysdomian_datagrid_edit_form_fieldName" type="text" reftype="-1"></td></tr><tr><td class="label" align="right" style="width:15%;">值</td><td align="left" style="width:85%;"><input id="i_sy_cxSbSysdomian_datagrid_edit_form_fieldValue" type="text" reftype="-1"></td></tr><tr><td class="label" align="right" style="width:15%;">描述/解释</td><td align="left" style="width:85%;"><input id="i_sy_cxSbSysdomian_datagrid_edit_form_fieldDesc" type="text" reftype="-1"></td></tr><tr><td class="label" align="right" style="width:15%;">备注</td><td align="left" style="width:85%;"><input id="i_sy_cxSbSysdomian_datagrid_edit_form_note" type="text" reftype="-1"></td></tr><tr style="display:none;"><td class="label" align="right" style="width:15%;display:none;">序号</td><td align="left" style="width:85%;display:none;"><input id="i_sy_cxSbSysdomian_datagrid_edit_form_id" type="text" reftype="-1"></td></tr></tbody></table></form>
<!-- 请填入编辑表单html  end -->
<div id="report_ps"> 
</div>
</div>
</div>
</div>

<!-- 按钮 start -->
<div id="i_sy_cxSbSysdomian_datagrid_edit_btn">
		<a href="#" class="easyui-linkbutton"
			data-options="iconCls:'icon-edit',plain:true">修改</a>
	</div>
	<div id="i_sy_cxSbSysdomian_datagrid_add_btn">
		<a href="#" class="easyui-linkbutton"
			data-options="iconCls:'icon-edit',plain:true">确定</a>
	</div>
	<div id="i_flowtoobar"></div>
<!-- 按钮 end -->

<div id="i_sy_cxSbSysdomian_datagrid_upload_dialog" class="easyui-dialog" title="上传" style="width:400px;height:100px;"  
        data-options="iconCls:'icon-save',resizable:true,modal:true,closed:true"> 
          <form id="i_sy_cxSbSysdomian_datagrid_upload_dialog_form" action="" enctype="multipart/form-data" method="post" >
    <input type="text" name="fileid"  style="display:none;"/>上传文件：<input type="file" name="fileGroup"></br><span style="color:red">注：由于服务器的空间有限，上传文件大小不能超过1G</span></br>
        	<input type="button" value="上传" onClick="submitUploadForm();" />
        	</form>
</div>  

</body>
</html>