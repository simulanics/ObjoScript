#tag Class
Protected Class VM
	#tag Method, Flags = &h0
		Sub Constructor()
		  mDisassembler = New ObjoScript.Disassembler
		  AddHandler mDisassembler.Print, AddressOf DisassemblerPrintDelegate
		  AddHandler mDisassembler.PrintLine, AddressOf DisassemblerPrintLineDelegate
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21, Description = 44656C6567617465206D6574686F6420746861742069732063616C6C6564206279206F757220646973617373656D626C6572277320605072696E74282960206576656E742E
		Private Sub DisassemblerPrintDelegate(sender As ObjoScript.Disassembler, s As String)
		  /// Delegate method that is called by our disassembler's `Print()` event.
		  ///
		  /// We will add `s` to our disassembler output buffer until the disassembler raises its `PrintLine()` event.
		  
		  #If DebugBuild
		    mDisassemblerOutput.Add(s)
		  #EndIf
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21, Description = 44656C6567617465206D6574686F6420746861742069732063616C6C6564206279206F757220646973617373656D626C6572277320605072696E744C696E65282960206576656E742E
		Private Sub DisassemblerPrintLineDelegate(sender As ObjoScript.Disassembler, s As String)
		  /// Delegate method that is called by our disassembler's `PrintLine()` event.
		  ///
		  /// Dump the contents of the disassembler's buffer and `s` to the debug log.
		  
		  #If DebugBuild
		    mDisassemblerOutput.Add(s)
		    System.DebugLog(String.FromArray(mDisassemblerOutput))
		    mDisassemblerOutput.ResizeTo(-1)
		  #EndIf
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21, Description = 526169736573206120564D457863657074696F6E206174207468652063757272656E742049502028756E6C657373206F746865727769736520737065636966696564292E
		Private Sub Error(message As String, offset As Integer = -1)
		  /// Raises a VMException at the current IP (unless otherwise specified).
		  
		  // Default to the current IP if no offset is provided.
		  offset = If(offset = -1, IP, offset)
		  
		  Raise New ObjoScript.VMException(message, Chunk.LineForOffset(offset), Chunk.ScriptIDForOffset(offset))
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Interpret(chunk As ObjoScript.Chunk)
		  Self.Chunk = chunk
		  Self.IP = 0
		  Run
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21, Description = 526561647320746865206279746520696E20604368756E6B60206174207468652063757272656E74206049506020616E642072657475726E732069742E20496E6372656D656E7473207468652049502E
		Private Function ReadByte() As UInt8
		  /// Reads the byte in `Chunk` at the current `IP` and returns it. Increments the IP.
		  
		  IP = IP + 1
		  Return Chunk.ReadByte(IP - 1)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21, Description = 5265616473206120636F6E7374616E742066726F6D20746865206368756E6B277320636F6E7374616E7420706F6F6C207573696E6720612073696E676C652062797465206F706572616E642E20496E6372656D656E74732049502E
		Private Function ReadConstant() As Variant
		  /// Reads a constant from the chunk's constant pool using a single byte operand. Increments IP.
		  
		  // The bytecode at `IP` gives us the index in the constant pool.
		  
		  Return Chunk.Constants(ReadByte)
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21, Description = 5265616473206120636F6E7374616E742066726F6D20746865206368756E6B277320636F6E7374616E7420706F6F6C207573696E672074776F2062797465206F706572616E64732E20496E6372656D656E74732049502E
		Private Function ReadConstantLong() As Variant
		  /// Reads a constant from the chunk's constant pool using two byte operands. Increments IP.
		  
		  // The bytecode at `IP` gives us the index in the constant pool.
		  
		  Return Chunk.Constants(ReadUInt16)
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21, Description = 52656164732074776F2062797465732066726F6D20604368756E6B60206174207468652063757272656E74206049506020616E642072657475726E73207468656D20617320612055496E7431362E20496E6372656D656E74732074686520495020627920322E
		Private Function ReadUInt16() As UInt16
		  /// Reads two bytes from `Chunk` at the current `IP` and returns them as a UInt16. Increments the IP by 2.
		  
		  IP = IP + 2
		  Return Chunk.ReadUInt16(IP - 2)
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub Run()
		  While True
		    #If DebugBuild And TRACE_EXECUTION
		      Call mDisassembler.DisassembleInstruction(-1, -1, Chunk, IP)
		    #EndIf
		    
		    Select Case ReadByte
		    Case OP_RETURN
		      Return
		      
		    Case OP_CONSTANT
		      Var constant As Variant = ReadConstant
		      System.DebugLog(constant.StringValue)
		      
		    Case OP_CONSTANT_LONG
		      Var constant As Variant = ReadConstantLong
		      System.DebugLog(constant.StringValue)
		      
		    Else
		      Error("Unknown opcode.", IP - 1)
		    End Select
		  Wend
		End Sub
	#tag EndMethod


	#tag Property, Flags = &h0, Description = 546865206368756E6B206F6620636F6465207468697320564D2069732063757272656E746C7920696E74657270726574696E672E
		Chunk As ObjoScript.Chunk
	#tag EndProperty

	#tag Property, Flags = &h0, Description = 54686520696E737472756374696F6E20706F696E7465722E2054686520696E64657820696E20746865206368756E6B27732060436F646560206172726179206F662074686520696E737472756374696F6E202A61626F757420746F2062652065786563757465642A2E
		IP As Integer = 0
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mDisassembler As ObjoScript.Disassembler
	#tag EndProperty

	#tag Property, Flags = &h21, Description = 54686520737472696E6773207061737365642062792074686520646973617373656D626C6572277320605072696E74282960206576656E742061726520616464656420746F2074686973206275666665722E204974277320636C6561726564207768656E2074686520646973617373656D626C6572207261697365732069747320605072696E744C696E65282960206576656E742E
		Private mDisassemblerOutput() As String
	#tag EndProperty


	#tag Constant, Name = OP_CONSTANT, Type = Double, Dynamic = False, Default = \"1", Scope = Public, Description = 5468652061646420636F6E7374616E74206F70636F64652E
	#tag EndConstant

	#tag Constant, Name = OP_CONSTANT_LONG, Type = Double, Dynamic = False, Default = \"2", Scope = Public, Description = 5468652061646420636F6E7374616E74202831362D62697429206F70636F64652E
	#tag EndConstant

	#tag Constant, Name = OP_RETURN, Type = Double, Dynamic = False, Default = \"0", Scope = Public, Description = 5468652072657475726E206F70636F64652E
	#tag EndConstant

	#tag Constant, Name = TRACE_EXECUTION, Type = Boolean, Dynamic = False, Default = \"True", Scope = Public, Description = 496620547275652028616E6420746869732069732061206465627567206275696C6429207468656E2074686520564D2077696C6C206F757470757420646562756720696E666F726D6174696F6E20746F207468652073797374656D206465627567206C6F672E204E6F2065666665637420696E20636F6D70696C656420617070732E
	#tag EndConstant


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
		#tag ViewProperty
			Name="IP"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
	#tag EndViewBehavior
End Class
#tag EndClass
