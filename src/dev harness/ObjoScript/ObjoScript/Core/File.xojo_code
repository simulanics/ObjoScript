#tag Module
Protected Module File
	#tag Method, Flags = &h1, Description = 54686520757365722069732063616C6C696E6720746865204D6174687320636C61737320636F6E7374727563746F722E
		Protected Sub Allocate(vm As ObjoScript.VM, instance As ObjoScript.Instance, args() As Variant)
		  // The user is calling the Maths class constructor.
		  
		  #Pragma Unused instance
		  #Pragma Unused args
		  
		  vm.Error("You cannot instantiate the Maths class.")
		  
		  'If arguments.Count <> 1 Then
		  'vm.Error("Expected a single `path` argument.")
		  'End If
		  '
		  '// Get the file as a Xojo FolderItem. Obviously you should do error checking, etc.
		  '// We'll store it in the instance's foreign data.
		  'instance.ForeignData = New FolderItem(arguments(0))
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1, Description = 52657475726E7320746865206D6574686F6420746F20696E766F6B6520666F72206120666F726569676E206D6574686F64207769746820607369676E617475726560206F6E2074686520604D617468736020636C617373206F72204E696C206966207468657265206973206E6F2073756368206D6574686F642E
		Protected Function BindForeignMethod(signature As String, isStatic As Boolean) As ObjoScript.ForeignMethodDelegate
		  /// Returns the method to invoke for a foreign method with `signature` on the `File` class or Nil if there is no such method.
		  
		  If isStatic Then
		    Return StaticMethods.Lookup(signature, Nil)
		  Else
		    Return Nil
		  End If
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1, Description = 52657475726E73207468652076616C7565206F66206065602C207468652062617365206F66206E61747572616C206C6F6761726974686D732E
		Protected Sub CopyTo(vm As ObjoScript.VM)
		  
		  
		  Var fItem As String = vm.GetSlotValue(1)
		  Var fItem2 As String = vm.GetSlotValue(2)
		  
		  var f as FolderItem = new FolderItem(fItem)
		  var f2 as FolderItem = new FolderItem(fItem2)
		  
		  if IsNull(f) then
		    
		    //return the result
		    vm.Error("NilIOException - No file item was specified.")
		    vm.SetReturn(false)
		    
		  elseif not f.Exists then
		    //return the result
		    vm.Error("IOException - A file already exists at the specified path.")
		    vm.SetReturn(false)
		  else
		    
		    try
		      #Pragma BreakOnExceptions False
		      f.CopyTo(f2)
		      vm.SetReturn(True)
		    Catch err 
		      vm.Error("IOException - " + err.Message)
		      vm.SetReturn(False)
		    end try
		    
		  end if
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21, Description = 52657475726E73206120636173652D73656E7369746976652064696374696F6E617279206D617070696E6720746865207369676E617475726573206F6620666F726569676E20737461746963206D6574686F6420746F20586F6A6F206D6574686F64206164647265737365732E
		Private Function InitialiseStaticMethodsDictionary() As Dictionary
		  /// Returns a case-sensitive dictionary mapping the signatures of foreign static method to Xojo method addresses.
		  
		  Var d As Dictionary = ParseJSON("{}") // HACK: Case-sensitive dictionary.
		  
		  d.Value("copy(_,_)") = AddressOf CopyTo
		  d.Value("move(_,_)") = AddressOf MoveTo
		  d.Value("read(_)")     = AddressOf ReadFile
		  d.Value("remove(_)") = AddressOf RemoveFile
		  d.Value("temporary()") = AddressOf Temporary
		  d.Value("write(_,_)")  = AddressOf WriteFile
		  
		  
		  Return d
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1, Description = 52657475726E73207468652076616C7565206F66206065602C207468652062617365206F66206E61747572616C206C6F6761726974686D732E
		Protected Sub MoveTo(vm As ObjoScript.VM)
		  
		  
		  Var fItem As String = vm.GetSlotValue(1)
		  Var fItem2 As String = vm.GetSlotValue(2)
		  
		  var f as FolderItem = new FolderItem(fItem)
		  var f2 as FolderItem = new FolderItem(fItem2)
		  
		  if IsNull(f) then
		    
		    //return the result
		    vm.Error("NilIOException - No file item was specified.")
		    vm.SetReturn(false)
		    
		  elseif not f.Exists then
		    //return the result
		    vm.Error("IOException - A file already exists at the specified path.")
		    vm.SetReturn(false)
		  else
		    
		    try
		      #Pragma BreakOnExceptions False
		      f.MoveTo(f2)
		      vm.SetReturn(True)
		    Catch err 
		      vm.Error("IOException - " + err.Message)
		      vm.SetReturn(False)
		    end try
		    
		  end if
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1, Description = 52657475726E73207468652076616C7565206F66206065602C207468652062617365206F66206E61747572616C206C6F6761726974686D732E
		Protected Sub ReadFile(vm As ObjoScript.VM)
		  
		  
		  Var fItem As String = vm.GetSlotValue(1)
		  var f as FolderItem = new FolderItem(fItem)
		  
		  if IsNull(f) then
		    
		  elseif not f.Exists then
		    //return the result
		    vm.Error("IOException - The specified file or path does not exist.")
		    vm.SetReturn(false)
		  else
		    
		    var t as TextInputStream
		    t = TextInputStream.Open(f)
		    var s as string = t.ReadAll()
		    t.Close()
		    
		    //return the result
		    vm.SetReturn(s)
		    
		  end if
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1, Description = 52657475726E73207468652076616C7565206F66206065602C207468652062617365206F66206E61747572616C206C6F6761726974686D732E
		Protected Sub RemoveFile(vm As ObjoScript.VM)
		  
		  
		  Var fItem As String = vm.GetSlotValue(1)
		  var f as FolderItem = new FolderItem(fItem)
		  
		  if IsNull(f) then
		    
		    //return the result
		    vm.Error("NilIOException - No file item was specified.")
		    vm.SetReturn(false)
		    
		  elseif not f.Exists then
		    //return the result
		    vm.Error("IOException - The specified file or path does not exist.")
		    vm.SetReturn(false)
		  else
		    
		    try
		      #Pragma BreakOnExceptions False
		      f.Remove()
		      vm.SetReturn(True)
		    Catch err 
		      vm.Error("IOException - " + err.Message)
		      vm.SetReturn(False)
		    end try
		    
		  end if
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1, Description = 52657475726E73207468652076616C7565206F66206065602C207468652062617365206F66206E61747572616C206C6F6761726974686D732E
		Protected Sub Temporary(vm As ObjoScript.VM)
		  
		  
		  vm.SetReturn(FolderItem.TemporaryFile.Parent.NativePath.ReplaceAll("\","\\"))
		  
		  
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1, Description = 52657475726E73207468652076616C7565206F66206065602C207468652062617365206F66206E61747572616C206C6F6761726974686D732E
		Protected Sub WriteFile(vm As ObjoScript.VM)
		  
		  Var fItem As String = vm.GetSlotValue(1)
		  var fContent as String = vm.GetSlotValue(2)
		  
		  
		  try
		    #Pragma BreakOnExceptions False
		    var f as FolderItem = new FolderItem(fItem)
		    
		    var t as TextOutputStream
		    t = TextOutputStream.Create(f)
		    t.Write(fContent)
		    t.Close()
		    
		    //return the result
		    vm.SetReturn(true)
		    
		  Catch err
		    
		    Select case err.ErrorNumber
		      
		    case 5 //IOException - Path inaccessible or invalid
		      
		      vm.Error("IOException - Specified path is inaccessible (read-only/system) or is invalid.")
		      
		    case else
		      
		      vm.Error(err.Message)
		      
		    end Select
		    
		  end try
		  
		  //return the result
		  vm.SetReturn(false)
		End Sub
	#tag EndMethod


	#tag ComputedProperty, Flags = &h1, Description = 436F6E7461696E7320616C6C20666F726569676E20737461746963206D6574686F647320646566696E6564206F6E20746865204D6174687320636C6173732E204B6579203D207369676E61747572652028737472696E67292C2056616C7565203D20416464726573734F6620586F6A6F206D6574686F642E
		#tag Getter
			Get
			  Static d As Dictionary = InitialiseStaticMethodsDictionary
			  
			  Return d
			  
			End Get
		#tag EndGetter
		Protected StaticMethods As Dictionary
	#tag EndComputedProperty


	#tag ViewBehavior
		#tag ViewProperty
			Name="Name"
			Visible=true
			Group="ID"
			InitialValue=""
			Type="String"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Index"
			Visible=true
			Group="ID"
			InitialValue="-2147483648"
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Super"
			Visible=true
			Group="ID"
			InitialValue=""
			Type="String"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Left"
			Visible=true
			Group="Position"
			InitialValue="0"
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Top"
			Visible=true
			Group="Position"
			InitialValue="0"
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
	#tag EndViewBehavior
End Module
#tag EndModule
