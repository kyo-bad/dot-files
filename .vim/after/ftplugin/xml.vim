if exists('b:did_ftplugin_xml')
  finish
endif
let b:did_ftplugin_xml = 1

setlocal tabstop=2 "インデントをスペース2つ分に設定
setlocal shiftwidth=2 "自動インデントの幅
setlocal smartindent "オートインデント
setlocal smarttab "新しい行を作った時に高度な自動インデント

setlocal omnifunc=xmlcomplete#CompleteTags