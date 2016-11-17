/**
 * 处理Grid重新加载过后selectionModel中的记录不更新的问题
 * me.selected中存放的是选中的记录的集合
 */
Ext.override(Ext.selection.Model,{
	onStoreLoad:function(store, records, successful, eOpts){
		var me = this,
			length = me.selected.getCount( );
		
		//如果没有选中的记录，则不需要进行任何的操作
		if(length===0)return;
		
		//遍历selected并更新其中的记录
		me.selected.eachKey(function(key,item){
			var model = store.getById(key);
			
			//如果获取到了model就更新，否则从selected中移除
			if(model){
				me.selected.add(model);//add时会覆盖掉原来的值
			}else{
				me.selected.removeAtKey(key);
			}
		})
		
	}
});