#!/usr/local/bin/io
//mainfile
//written by peppo
//2016/05/27
//***discription********************************
//*Try it.
//*arg 1: url 
//**********************************************
parseHTML := method(
  url := System args at(1),

  SGML#use SGML addon
  Bot := Object clone//root object!
  Bot HC := HttpClient clone //clone Httpclient 4 use HCUrl
  Bot HC HCRequest setHeader("User-Agent","Mozilla/5.0 (Windows NT 10.0) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/51.0.2704.63 Safari/537.36")//user fake UA
  Bot HC HCRequest setHeader("Referer",System args at(1))//
  Bot HC HCRequest setHeader("Accept","*/*")//set mediatype
  Bot HC HCRequest setHeader("Cache-Control","no-cache")//Cache-Control
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
)
parseHTML()
exit 0

//TODO//
//1.init
