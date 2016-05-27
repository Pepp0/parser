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
  method := System args at(2)
SGML#use SGML addon
  Parser := Object clone do(//root object!
    HC := HttpClient clone do( //clone Httpclient 4 use HCUrl
      HCRequest setHeader("User-Agent","Mozilla/5.0 (Windows NT 10.0) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/51.0.2704.63 Safari/537.36")//user fake UA
      HCRequest setHeader("Referer",System args at(1))//
      HCRequest setHeader("Accept","*/*")//set mediatype
      HCRequest setHeader("Cache-Control","no-cache")//Cache-Control
      HCRequest setHeader("Connection","keep-alive")//connection setting
      HCRequest setHeader("Host",System args at(1))//set fake host header
      HCRequest method = System args at(2)?"GET"
      HCUrl urlSeq := System args at(1)//url ready
      rslt := HCUrl getResponse content
    )
  )

  rslt := Parser HC rslt
  /*SGML*/
  ParseHTML := Parser HC rslt asUTF8 println#rslt convart to list


  //logging
  Parser logfile := File with(System launchPath .. "/" .. "log.txt")
  Parser logfile remove openForUpdating setContents(ParseHTML asString) close
  //convart charaset use nkf
  Parser sh := System clone do(
    system("nkf -w -b --overwrite " .. System launchPath .. "/log.txt")
  )
)
parseHTML()
exit

//TODO//
//1.init
