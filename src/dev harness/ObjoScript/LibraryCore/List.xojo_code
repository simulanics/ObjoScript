#tag Module
Protected Module List
	#tag Method, Flags = &h1, Description = 41206E6577204C69737420696E7374616E6365206973206265696E6720616C6C6F63617465642E
		Protected Sub Allocate(vm As ObjoScript.VM, instance As ObjoScript.Instance, args() As Variant)
		  /// A new List instance is being allocated.
		  ///
		  /// constructor()
		  
		  If args.Count = 0 Then
		    Var data() As Variant
		    instance.ForeignData = data
		    instance.Fields.Value("_next") = False
		    instance.Fields.Value("_index") = -1
		  Else
		    vm.Error("Invalid number of arguments (expected 0, got " + args.Count.ToString + ").")
		  End If
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1, Description = 52657475726E7320746865206D6574686F6420746F20696E766F6B6520666F72206120666F726569676E206D6574686F64207769746820607369676E617475726560206F6E2074686520604C6973746020636C617373206F72204E696C206966207468657265206973206E6F2073756368206D6574686F642E
		Protected Function BindForeignMethod(signature As String, isStatic As Boolean) As ObjoScript.ForeignMethodDelegate
		  /// Returns the method to invoke for a foreign method with `signature` on the `List` class or Nil if there is no such method.
		  
		  #Pragma Unused isStatic
		  
		  If signature.CompareCase("iterate(_)") Then
		    Return AddressOf Iterate
		    
		  ElseIf signature.CompareCase("iteratorValue(_)") Then
		    Return AddressOf IteratorValue
		  End If
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1, Description = 52657475726E732066616C736520696620746865726520617265206E6F206D6F7265206974656D7320746F2069746572617465206F722072657475726E7320746865206E6578742076616C756520696E207468652073657175656E63652E
		Protected Sub Iterate(vm As ObjoScript.VM)
		  /// Returns false if there are no more items to iterate or returns the next value in the sequence.
		  ///
		  /// if `iter` is nothing then we should return the first item.
		  /// Assumes slot 0 contains a List instance.
		  /// List.iterate(iter) -> value or false
		  
		  Var instance As ObjoScript.Instance = vm.GetSlotValue(0)
		  Var iter As Variant = vm.GetSlotValue(1)
		  
		  Var next_ As Variant = instance.Fields.Value("_next")
		  Var index_ As Double = instance.Fields.Value("_index")
		  
		  Var elements() As Variant = instance.ForeignData
		  
		  If iter IsA ObjoScript.Nothing Then
		    // Return the first element.
		    If elements.Count = 0 Then
		      // This is an empty list.
		      next_ = False
		    Else
		      index_ = 0
		      next_ = elements(0)
		    End If
		  Else
		    // Return the next element.
		    index_ = index_ + 1
		    If index_ <= elements.LastIndex Then
		      next_ = elements(index_)
		    Else
		      next_ = False
		    End If
		  End If
		  
		  instance.Fields.Value("_next") = next_
		  instance.Fields.Value("_index") = index_
		  
		  vm.SetReturn(next_)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1, Description = 52657475726E7320746865206E657874206974657261746F722076616C75652E
		Protected Sub IteratorValue(vm As ObjoScript.VM)
		  /// Returns the next iterator value.
		  ///
		  /// Assumes slot 0 contains a List instance.
		  /// We are ignoring `iter` here.
		  /// List.iterator(iter) -> value
		  
		  Var instance As ObjoScript.Instance = vm.GetSlotValue(0)
		  
		  vm.SetReturn(instance.Fields.Value("_next"))
		  
		End Sub
	#tag EndMethod


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