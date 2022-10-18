#tag Class
Protected Class Assert
	#tag Method, Flags = &h0
		Sub AreDifferent(expected As Object, actual As Object, message As String = "", data As String = "")
		  If Not (expected Is actual) Then
		    Pass(message, data)
		  Else
		    Fail("Objects are the same", message, data)
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub AreDifferent(expected As String, actual As String, message As String = "", data As String = "")
		  If expected.Encoding <> actual.Encoding Or expected.Compare(actual, ComparisonOptions.CaseSensitive) <> 0 Then
		    Pass(message, data)
		  Else
		    Fail("String '" + actual + "' is the same", message, data)
		  End If
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Attributes( Deprecated )  Sub AreDifferent(expected As Text, actual As Text, message As String = "", data As String = "")
		  If expected.Compare(actual, Text.CompareCaseSensitive) <> 0 Then
		    Pass(message, data)
		  Else
		    Fail("Text '" + actual + "' is the same", message, data)
		  End If
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub AreEqual(expected As Color, actual As Color, message As String = "", data As String = "")
		  Var expectedColor, actualColor As String
		  
		  If expected = actual Then
		    Pass(message, data)
		  Else
		    expectedColor = "RGB(" + expected.Red.ToString + ", " + expected.Green.ToString + ", " + expected.Blue.ToString + ")"
		    actualColor = "RGB(" + actual.Red.ToString + ", " + actual.Green.ToString + ", " + actual.Blue.ToString + ")"
		    Fail(FailEqualMessage(expectedColor, actualColor), message, data)
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub AreEqual(expected As Currency, actual As Currency, message As String = "", data As String = "")
		  If expected = actual Then
		    Pass(message, data)
		  Else
		    Fail(FailEqualMessage(expected.ToString, actual.ToString), message, data)
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0, CompatibilityFlags = (not TargetHasGUI and not TargetWeb and not TargetIOS) or  (TargetWeb) or  (TargetHasGUI) or  (TargetIOS)
		Sub AreEqual(expected As DateTime, actual As DateTime, message As String = "", data As String = "")
		  If expected Is Nil Xor actual Is Nil Then
		    Fail("One given Date is Nil", message, data)
		  ElseIf expected Is actual Or expected.SecondsFrom1970 = actual.SecondsFrom1970 Then
		    Pass(message, data)
		  Else
		    Fail(FailEqualMessage(expected.SQLDateTime , actual.SQLDateTime), message, data)
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub AreEqual(expected() As Double, actual() As Double, message As String = "", data As String = "")
		  Var expectedSize, actualSize As Double
		  
		  expectedSize = expected.LastIndex
		  actualSize = actual.LastIndex
		  
		  If expectedSize <> actualSize Then
		    Fail( "Expected Integer array Ubound [" + expectedSize.ToString + _
		    "] but was [" + actualSize.ToString + "].", _
		    message, data)
		    Return
		  End If
		  
		  For i As Integer = 0 To expectedSize
		    If expected(i) <> actual(i) Then
		      Fail( FailEqualMessage("Array(" + i.ToString + ") = '" + expected(i).ToString + "'", _
		      "Array(" + i.ToString + ") = '" + actual(i).ToString + "'"), _
		      message, data)
		      Return
		    End If
		  Next
		  
		  Pass(message, data)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub AreEqual(expected As Double, actual As Double, tolerance As Double, message As String = "", data As String = "")
		  Var diff As Double
		  
		  diff = Abs(expected - actual)
		  If diff <= (Abs(tolerance) + 0.00000001) Then
		    Pass(message, data)
		  Else
		    Fail(FailEqualMessage(expected.ToString(Locale.Current, "#########.##########"), actual.ToString(Locale.Current, "#########.##########")), message, data)
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub AreEqual(expected As Double, actual As Double, message As String = "", data As String = "")
		  Var tolerance As Double = 0.00000001
		  
		  AreEqual(expected, actual, tolerance, message, data)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0, CompatibilityFlags = (not TargetHasGUI and not TargetWeb and not TargetIOS) or  (TargetWeb) or  (TargetHasGUI)
		Sub AreEqual(expected As Global.MemoryBlock, actual As Global.MemoryBlock, message As String = "", data As String = "")
		  If expected = actual Then
		    Pass(message, data)
		    Return
		  End If
		  
		  If expected Is Nil Xor actual Is Nil Then
		    Fail("One given MemoryBlock is Nil", message, data)
		    Return
		  End If
		  
		  Var expectedSize As Integer = expected.Size
		  Var actualSize As Integer = actual.Size
		  
		  If expectedSize <> actualSize Then
		    Fail( "Expected MemoryBlock Size [" + expectedSize.ToString + _
		    "] but was [" + actualSize.ToString + "].", _
		    message, data)
		    Return
		  End If
		  
		  Var sExpected As String = expected.StringValue(0, expectedSize)
		  Var sActual As String = actual.StringValue(0, actualSize)
		  
		  If sExpected.Compare(sActual, ComparisonOptions.CaseSensitive) = 0 Then
		    Pass(message, data)
		  Else
		    Fail(FailEqualMessage(EncodeHex(sExpected, True), EncodeHex(sActual, True)), message, data)
		  End If
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub AreEqual(expected As Int16, actual As Int16, message As String = "", data As String = "")
		  If expected = actual Then
		    Pass(message, data)
		  Else
		    Fail(FailEqualMessage(expected.ToString, actual.ToString), message, data)
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub AreEqual(expected As Int32, actual As Int32, message As String = "", data As String = "")
		  If expected = actual Then
		    Pass(message, data)
		  Else
		    Fail(FailEqualMessage(expected.ToString, actual.ToString), message, data)
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub AreEqual(expected As Int64, actual As Int64, message As String = "", data As String = "")
		  If expected = actual Then
		    Pass(message, data)
		  Else
		    Fail(FailEqualMessage(expected.ToString, actual.ToString), message, data)
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub AreEqual(expected As Int8, actual As Int8, message As String = "", data As String = "")
		  If expected = actual Then
		    Pass(message, data)
		  Else
		    Fail(FailEqualMessage(expected.ToString, actual.ToString), message, data)
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub AreEqual(expected() As Integer, actual() As Integer, message As String = "", data As String = "")
		  Var expectedSize, actualSize As Integer
		  
		  expectedSize = expected.LastIndex
		  actualSize = actual.LastIndex
		  
		  If expectedSize <> actualSize Then
		    Fail( "Expected Integer array Ubound [" + expectedSize.ToString + _
		    "] but was [" + actualSize.ToString + "].", _
		    message, data)
		    Return
		  End If
		  
		  For i As Integer = 0 To expectedSize
		    If expected(i) <> actual(i) Then
		      Fail( FailEqualMessage("Array(" + i.ToString + ") = '" + expected(i).ToString + "'", _
		      "Array(" + i.ToString + ") = '" + actual(i).ToString + "'"), _
		      message, data)
		      Return
		    End If
		  Next
		  
		  Pass(message, data)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0, CompatibilityFlags = (not TargetHasGUI and not TargetWeb and not TargetIOS) or  (TargetWeb) or  (TargetHasGUI)
		Sub AreEqual(expected() As String, actual() As String, message As String = "", data As String = "")
		  Var expectedSize, actualSize As Integer
		  
		  expectedSize = expected.LastIndex
		  actualSize = actual.LastIndex
		  
		  If expectedSize <> actualSize Then
		    Fail( "Expected String array Ubound [" + expectedSize.ToString + _
		    "] but was [" + actualSize.ToString + "].", _
		    message, data)
		    Return
		  End If
		  
		  For i As Integer = 0 To expectedSize
		    If expected(i) <> actual(i) Then
		      Fail( FailEqualMessage("Array(" + i.ToString + ") = '" + expected(i) + "'", _
		      "Array(" + i.ToString + ") = '" + actual(i) + "'"), _
		      message, data)
		      Return
		    End If
		  Next
		  
		  Pass(message, data)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0, CompatibilityFlags = (not TargetHasGUI and not TargetWeb and not TargetIOS) or  (TargetWeb) or  (TargetHasGUI)
		Sub AreEqual(expected As String, actual As String, message As String = "", data As String = "")
		  // This is a case-insensitive comparison
		  
		  If expected = actual Then
		    Pass(message, data)
		  Else
		    Fail(FailEqualMessage(expected, actual), message, data)
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub AreEqual(expected() As Text, actual() As Text, message As String = "", data As String = "")
		  Var expectedSize, actualSize As Integer
		  
		  expectedSize = expected.LastIndex
		  actualSize = actual.LastIndex
		  
		  If expectedSize <> actualSize Then
		    Fail( "Expected Text array Ubound [" + expectedSize.ToString + _
		    "] but was [" + actualSize.ToString + "].", _
		    message, data)
		    Return
		  End If
		  
		  For i As Integer = 0 To expectedSize
		    If expected(i).Compare(actual(i)) <> 0 Then
		      Fail( FailEqualMessage("Array(" + i.ToString + ") = '" + expected(i) + "'", _
		      "Array(" + i.ToString + ") = '" + actual(i) + "'"), _
		      message, data)
		      Return
		    End If
		  Next
		  
		  Pass(message, data)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub AreEqual(expected As UInt16, actual As UInt16, message As String = "", data As String = "")
		  If expected = actual Then
		    Pass(message, data)
		  Else
		    Fail(FailEqualMessage(expected.ToString, actual.ToString), message, data)
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub AreEqual(expected As UInt32, actual As UInt32, message As String = "", data As String = "")
		  If expected = actual Then
		    Pass(message, data)
		  Else
		    Fail(FailEqualMessage(expected.ToString, actual.ToString), message, data)
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub AreEqual(expected As UInt64, actual As UInt64, message As String = "", data As String = "")
		  If expected = actual Then
		    Pass(message, data)
		  Else
		    Fail(FailEqualMessage(expected.ToString, actual.ToString), message, data)
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub AreEqual(expected As UInt8, actual As UInt8, message As String = "", data As String = "")
		  If expected = actual Then
		    Pass(message, data)
		  Else
		    Fail(FailEqualMessage(expected.ToString, actual.ToString), message, data)
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub AreNotEqual(expected As Color, actual As Color, message As String = "", data As String = "")
		  Var expectedColor, actualColor As String
		  
		  If expected <> actual Then
		    Pass(message, data)
		  Else
		    expectedColor = "RGB(" + expected.Red.ToString + ", " + expected.Green.ToString + ", " + expected.Blue.ToString + ")"
		    actualColor = "RGB(" + actual.Red.ToString + ", " + actual.Green.ToString + ", " + actual.Blue.ToString + ")"
		    Fail(FailEqualMessage(expectedColor, actualColor), message, data)
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub AreNotEqual(expected As Currency, actual As Currency, message As String = "", data As String = "")
		  //NCM-written
		  If expected <> actual Then
		    Pass(message, data)
		  Else
		    Fail(FailEqualMessage(expected.ToString, actual.ToString), message, data)
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0, CompatibilityFlags = (not TargetHasGUI and not TargetWeb and not TargetIOS) or  (TargetWeb) or  (TargetHasGUI) or  (TargetIOS)
		Sub AreNotEqual(expected As DateTime, actual As DateTime, message As String = "", data As String = "")
		  If expected Is Nil Xor actual Is Nil Then
		    Pass(message, data)
		  ElseIf expected Is Nil And actual Is Nil Then
		    Fail("Both Dates are Nil", message, data)
		  ElseIf expected = actual Or expected.SecondsFrom1970 = actual.SecondsFrom1970 Then
		    Fail("Both Dates are the same", message, data)
		  Else
		    Pass(message, data)
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub AreNotEqual(expected As Double, actual As Double, tolerance As Double, message As String = "", data As String = "")
		  Var diff As Double
		  
		  diff = Abs(expected - actual)
		  If diff > (Abs(tolerance) + 0.00000001) Then
		    Pass(message, data)
		  Else
		    Fail(FailEqualMessage(expected.ToString(Locale.Current, "#########.##########"), actual.ToString(Locale.Current, "#########.##########")), message, data)
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub AreNotEqual(expected As Double, actual As Double, message As String = "", data As String = "")
		  Var tolerance As Double = 0.00000001
		  
		  AreNotEqual(expected, actual, tolerance, message, data)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0, CompatibilityFlags = (not TargetHasGUI and not TargetWeb and not TargetIOS) or  (TargetWeb) or  (TargetHasGUI)
		Sub AreNotEqual(expected As Global.MemoryBlock, actual As Global.MemoryBlock, message As String = "", data As String = "")
		  If expected = actual Then
		    Fail("The MemoryBlocks are the same", message, data)
		    
		  ElseIf expected Is Nil Xor actual Is Nil Then
		    Pass(message, data)
		    
		  Else
		    Var expectedSize As Integer = expected.Size
		    Var actualSize As Integer = actual.Size
		    
		    If expectedSize <> actualSize Then
		      Pass(message, data)
		      
		    Else
		      
		      Var sExpected As String = expected.StringValue(0, expectedSize)
		      Var sActual As String = actual.StringValue(0, actualSize)
		      
		      If sExpected.Compare(sActual, ComparisonOptions.CaseSensitive) <> 0 Then
		        Pass(message, data)
		      Else
		        Fail("The MemoryBlock is the same: " + EncodeHex(sExpected, True), message, data)
		      End If
		      
		    End If
		    
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub AreNotEqual(expected As Int16, actual As Int16, message As String = "", data As String = "")
		  If expected <> actual Then
		    Pass(message, data)
		  Else
		    Fail(FailEqualMessage(expected.ToString, actual.ToString), message, data)
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub AreNotEqual(expected As Int32, actual As Int32, message As String = "", data As String = "")
		  //NCM-written
		  If expected <> actual Then
		    Pass(message, data)
		  Else
		    Fail(FailEqualMessage(expected.ToString, actual.ToString), message, data)
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub AreNotEqual(expected As Int64, actual As Int64, message As String = "", data As String = "")
		  //NCM-written
		  If expected <> actual Then
		    Pass(message, data)
		  Else
		    Fail(FailEqualMessage(expected.ToString, actual.ToString), message, data)
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub AreNotEqual(expected As Int8, actual As Int8, message As String = "", data As String = "")
		  If expected <> actual Then
		    Pass(message, data)
		  Else
		    Fail(FailEqualMessage(expected.ToString, actual.ToString), message, data)
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0, CompatibilityFlags = (not TargetHasGUI and not TargetWeb and not TargetIOS) or  (TargetWeb) or  (TargetHasGUI)
		Sub AreNotEqual(expected As String, actual As String, message As String = "", data As String = "")
		  //NCM-written
		  If expected <> actual Then
		    Pass(message, data)
		  Else
		    Fail("The Strings '" + actual + " are equal but shouldn't be", message, data)
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub AreNotEqual(expected As UInt16, actual As UInt16, message As String = "", data As String = "")
		  If expected <> actual Then
		    Pass(message, data)
		  Else
		    Fail(FailEqualMessage(expected.ToString, actual.ToString), message, data)
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub AreNotEqual(expected As UInt32, actual As UInt32, message As String = "", data As String = "")
		  If expected <> actual Then
		    Pass(message, data)
		  Else
		    Fail(FailEqualMessage(expected.ToString, actual.ToString), message, data)
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub AreNotEqual(expected As UInt64, actual As UInt64, message As String = "", data As String = "")
		  //NCM-written
		  If expected <> actual Then
		    Pass(message, data)
		  Else
		    Fail(FailEqualMessage(expected.ToString, actual.ToString), message, data)
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub AreNotEqual(expected As UInt8, actual As UInt8, message As String = "", data As String = "")
		  If expected <> actual Then
		    Pass(message, data)
		  Else
		    Fail(FailEqualMessage(expected.ToString, actual.ToString), message, data)
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub AreSame(expected As Object, actual As Object, message As String = "", data As String = "")
		  If expected Is actual Then
		    Pass(message, data)
		  Else
		    Fail("Objects are not the same", message, data)
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub AreSame(expected() As String, actual() As String, message As String = "", data As String = "")
		  Var expectedSize, actualSize As Integer
		  
		  expectedSize = expected.LastIndex
		  actualSize = actual.LastIndex
		  
		  If expectedSize <> actualSize Then
		    Fail( "Expected String array LastIndex [" + expectedSize.ToString + _
		    "] but was [" + actualSize.ToString + "].", _
		    message, data)
		    Return
		  End If
		  
		  For i As Integer = 0 To expectedSize
		    If Not AreSameBytes(expected(i), actual(i)) Then
		      Fail(FailEqualMessage("Array(" + i.ToString + ") = '" + expected(i) + "'", _
		      "Array(" + i.ToString + ") = '" + actual(i) + "'"), _
		      message, data)
		      Return
		      
		    ElseIf expected(i).Encoding <> actual(i).Encoding Then
		      Fail("The text encoding of item " + i.ToString + " ('" + expected(i) + "') differs", message, data)
		      Return
		      
		    End If
		  Next
		  
		  Pass(message, data)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub AreSame(expected As String, actual As String, message As String = "", data As String = "")
		  If Not AreSameBytes(expected, actual) Then
		    Fail(FailEqualMessage(expected, actual), message, data )
		    
		  ElseIf Not expected.IsEmpty And expected.Encoding <> actual.Encoding Then
		    Fail("The bytes match but the text encoding does not", message, data)
		    
		  Else
		    Pass(message, data)
		    
		  End If
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Attributes( Deprecated )  Sub AreSame(expected() As Text, actual() As Text, message As String = "", data As String = "")
		  Var expectedSize, actualSize As Integer
		  
		  expectedSize = expected.LastIndex
		  actualSize = actual.LastIndex
		  
		  If expectedSize <> actualSize Then
		    Fail( "Expected Text array Ubound [" + expectedSize.ToString + _
		    "] but was [" + actualSize.ToString + "].", _
		    message, data)
		    Return
		  End If
		  
		  For i As Integer = 0 To expectedSize
		    If expected(i).Compare(actual(i), Text.CompareCaseSensitive) <> 0 Then
		      Fail( FailEqualMessage("Array(" + i.ToString + ") = '" + expected(i) + "'", _
		      "Array(" + i.ToString + ") = '" + actual(i) + "'"), _
		      message, data)
		      Return
		    End If
		  Next
		  
		  Pass(message, data)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Attributes( Deprecated )  Sub AreSame(expected As Text, actual As Text, message As String = "", data As String = "")
		  If expected.Compare(actual, Text.CompareCaseSensitive) = 0 Then
		    Pass(message, data)
		  Else
		    Fail(FailEqualMessage(expected, actual), message, data)
		  End If
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function AreSameBytes(s1 As String, s2 As String) As Boolean
		  If s1.IsEmpty And s2.IsEmpty Then
		    Return True
		    
		  ElseIf s1.Bytes <> s2.Bytes Then
		    Return False
		    
		  Else
		    Var mb1 As MemoryBlock = s1
		    Var mb2 As MemoryBlock = s2
		    
		    Return mb1 = mb2
		    
		  End If
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Destructor()
		  Group = Nil
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0, CompatibilityFlags = (TargetConsole and (Target32Bit or Target64Bit)) or  (TargetWeb and (Target32Bit or Target64Bit)) or  (TargetDesktop and (Target32Bit or Target64Bit))
		Sub DoesNotMatch(regExPattern As String, actual As String, message As String = "")
		  If regExPattern = "" Then
		    Var err As New RegExException
		    err.Message = "No pattern was specified"
		    Raise err
		  End If
		  
		  Var rx As New RegEx
		  rx.SearchPattern = regExPattern
		  
		  If rx.Search(actual) Is Nil Then
		    Pass()
		  Else
		    Fail("[" + actual + "]  matches the pattern /" + regExPattern + "/", message)
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Fail(failMessage As String, message As String = "", data As String = "")
		  If Group Is Nil Or Group.CurrentTestResult Is Nil Then
		    //
		    // Don't do anything
		    //
		    Return
		  End If
		  
		  Failed = True
		  Group.CurrentTestResult.Result = TestResult.Failed
		  FailCount = FailCount + 1
		  
		  Message(message + If(message <> "", ": ", "") + failMessage)
		  
		  Group.CurrentTestResult.Data = data
		  
		  If Group.StopTestOnFail Then
		    #Pragma BreakOnExceptions False
		    Raise New XojoUnitTestFailedException
		    #Pragma BreakOnExceptions Default
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function FailEqualMessage(expected As String, actual As String) As String
		  Var message As String
		  
		  message = "Expected:" + EndOfLine + EndOfLine + expected + EndOfLine + EndOfLine + "Instead got:" + EndOfLine + EndOfLine + actual
		  
		  Return message
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub IsFalse(condition As Boolean, message As String = "", data As String = "")
		  If condition Then
		    Fail("[false] expected, but was [true].", message, data)
		  Else
		    Pass(message, data)
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub IsNil(anObject As Object, message As String = "", data As String = "")
		  If anObject = Nil Then
		    Pass(message, data)
		  Else
		    Fail("Object was expected to be [nil], but was not.", message, data)
		  End If
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub IsNotNil(anObject As Object, message As String = "", data As String = "")
		  If anObject <> Nil Then
		    Pass(message, data)
		  Else
		    Fail("Expected value not to be [nil], but was [nil].", message, data)
		  End If
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub IsTrue(condition As Boolean, message As String = "", data As String = "")
		  If condition Then
		    Pass(message, data)
		  Else
		    Fail("[true] expected, but was [false].", message, data)
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0, CompatibilityFlags = (TargetConsole and (Target32Bit or Target64Bit)) or  (TargetWeb and (Target32Bit or Target64Bit)) or  (TargetDesktop and (Target32Bit or Target64Bit))
		Sub Matches(regExPattern As String, actual As String, message As String = "", data As String = "")
		  If regExPattern = "" Then
		    Var err As New RegExException
		    err.Message = "No pattern was specified"
		    Raise err
		  End If
		  
		  Var rx As New RegEx
		  rx.SearchPattern = regExPattern
		  
		  If rx.Search(actual) Is Nil Then
		    Fail("[" + actual + "]  does not match the pattern /" + regExPattern + "/", message, data)
		  Else
		    Pass(message, data)
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Message(msg As String)
		  If Group Is Nil Or Group.CurrentTestResult Is Nil Then
		    //
		    // Don't do anything
		    //
		    Return
		  End If
		  
		  msg = msg.Trim
		  If msg.IsEmpty Then
		    Return
		  End If
		  
		  If Group.CurrentTestResult.Message.IsEmpty Then
		    Group.CurrentTestResult.Message = msg
		  Else
		    Group.CurrentTestResult.Message = Group.CurrentTestResult.Message + &u0A + msg
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Pass(message As String = "", data As String = "")
		  If Group Is Nil Or Group.CurrentTestResult Is Nil Then
		    //
		    // Don't do anything
		    //
		    Return
		  End If
		  
		  Group.CurrentTestResult.Data = data
		  
		  Failed = False
		  If Group.CurrentTestResult.Result <> TestResult.Failed Then
		    Group.CurrentTestResult.Result = TestResult.Passed
		    Message(message)
		  End If
		  
		End Sub
	#tag EndMethod


	#tag Property, Flags = &h0
		FailCount As Integer
	#tag EndProperty

	#tag Property, Flags = &h0
		Failed As Boolean
	#tag EndProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  If mGroupWeakRef Is Nil Then
			    Return Nil
			  Else
			    Return TestGroup(mGroupWeakRef.Value)
			  End If
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  If value Is Nil Then
			    mGroupWeakRef = Nil
			  Else
			    mGroupWeakRef = new WeakRef(value)
			  End If
			End Set
		#tag EndSetter
		Group As TestGroup
	#tag EndComputedProperty

	#tag Property, Flags = &h21
		Private mGroupWeakRef As WeakRef
	#tag EndProperty


	#tag ViewBehavior
		#tag ViewProperty
			Name="Failed"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Boolean"
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
			Name="Left"
			Visible=true
			Group="Position"
			InitialValue="0"
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Name"
			Visible=true
			Group="ID"
			InitialValue=""
			Type="String"
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
			Name="Top"
			Visible=true
			Group="Position"
			InitialValue="0"
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="FailCount"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
	#tag EndViewBehavior
End Class
#tag EndClass
