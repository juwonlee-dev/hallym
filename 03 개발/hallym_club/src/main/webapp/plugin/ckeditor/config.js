/**
 * @license Copyright (c) 2003-2020, CKSource - Frederico Knabben. All rights reserved.
 * For licensing, see https://ckeditor.com/legal/ckeditor-oss-license
 */

CKEDITOR.editorConfig = function( config ) {
	// Define changes to default configuration here. For example:
	// config.language = 'fr';
	// config.uiColor = '#AADC6E';
	config.toolbarGroups = [
		{ name: 'document', groups: [ '-', 'Preview', 'Print', 'Templates' ] },
		{ name: 'clipboard', groups: [ 'Cut', 'Copy', 'Paste', 'PasteText', 'PasteFromWord', '-', 'Undo', 'Redo' ] },
		{ name: 'editing', groups: [ 'Find', 'Replace', '-', 'SelectAll', '-', 'Scayt' ] },
		{ name: 'tools', groups: [ 'Maximize', 'ShowBlocks' ] },
		{ name: 'about', groups: [ 'About' ] },
		'/',
		{ name: 'styles', groups: [ 'Styles', 'Format', 'Font', 'FontSize' ] },
		{ name: 'colors', groups: [ 'TextColor', 'BGColor' ] },
		{ name: 'basicstyles', groups: [ 'Bold', 'Italic', 'Underline', 'Strike', 'Subscript', 'Superscript', '-', 'CopyFormatting', 'RemoveFormat' ] },
		'/',
		{ name: 'paragraph', groups: [ 'NumberedList', 'BulletedList', '-', 'Outdent', 'Indent', '-', 'Blockquote', 'CreateDiv', '-', 'JustifyLeft', 'JustifyCenter', 'JustifyRight', 'JustifyBlock', '-', 'BidiLtr', 'BidiRtl', 'Language' ] },
		{ name: 'links', groups: [ 'Link', 'Unlink' ] },
		{ name: 'insert', groups: [ 'Image', 'Table', 'HorizontalRule', 'Smiley', 'SpecialChar', 'PageBreak' ] }
	];
	
	config.removeButtons = 'Source,Templates,NewPage,Save,Form,Checkbox,Radio,TextField,Textarea,Select,Button,ImageButton,HiddenField,Flash,Iframe,ShowBlocks,Anchor,CreateDiv';
	config.autoGrow_onStartup = true;
};
