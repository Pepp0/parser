#!/usr/local/bin/io
//mainfile
//written by peppo
//2016/05/27
//***discription********************************
//*Try it.
//*arg 1: url 
//**********************************************
//addons
SGML#use SGML addon
Regex
Bot := Object clone//root object!
Bot HC := HttpClient clone //clone Httpclient 4 use HCUrl
Bot HC HCRequest setHeader("User-Agent","Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/47.0.2526.106 Safari/537.36")//user fake UA
Bot HC HCRequest setHeader("Referer",System args at(1))//utamap need this
Bot HC HCRequest setHeader("Accept","*/*")//set mediatype
Bot HC HCRequest setHeader("Cache-Control","max-age=0")//Cache-Control
Bot HC HCRequest setHeader("Connection","keep-alive")//connection setting
Bot HC HCRequest setHeader("Host",System args at(1))//set fake host header


Bot HC HCUrl urlSeq := System args at(1)//url ready up!
Bot HC rslt := Bot HC HCUrl getResponse content println//fire^^ 2 change method!!!!//TODO

/*SGML*/
ParseHTML := Bot HC rslt asUTF8 asXML#rslt convart to list




//logging
Bot logfile := File with(System launchPath .. "/" .. "log.txt")
Bot logfile remove openForUpdating setContents(ParseHTML asString) close//write and close log
//convart charaset use nkf
Bot sh := System clone do(
  system("nkf -w -b --overwrite " .. System launchPath .. "/log.txt")
)
exit

//TODO//
//1.init
