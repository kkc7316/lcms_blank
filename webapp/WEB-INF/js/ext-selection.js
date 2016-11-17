/**
 * ����Grid���¼��ع���selectionModel�еļ�¼�����µ�����
 * me.selected�д�ŵ���ѡ�еļ�¼�ļ���
 */
Ext.override(Ext.selection.Model,{
	onStoreLoad:function(store, records, successful, eOpts){
		var me = this,
			length = me.selected.getCount( );
		
		//���û��ѡ�еļ�¼������Ҫ�����κεĲ���
		if(length===0)return;
		
		//����selected���������еļ�¼
		me.selected.eachKey(function(key,item){
			var model = store.getById(key);
			
			//�����ȡ����model�͸��£������selected���Ƴ�
			if(model){
				me.selected.add(model);//addʱ�Ḳ�ǵ�ԭ����ֵ
			}else{
				me.selected.removeAtKey(key);
			}
		})
		
	}
});