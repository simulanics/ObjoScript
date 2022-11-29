All development and testing of ObjoScript is done from within the dev harness. It's also a great way to experiment with the language and get a feel for its capabilities.

Once you have installed the required Xojo plugins (see [this page][repo contents]) simply load `src/dev harness/ObjoScript.xojo_project` in Xojo. You should be able to run the project immediately.

## IDE
By default the app launches with a blank IDE window for you to enter some ObjoScript code. To run a script simply click the run button in the top corner of the window (a triangle). The output from the script will be shown in the bottom left text area.

Once a script has run / is running, you can inspect the following using the buttons in the top right of the window:

**AST:**
This will show the abstract syntax tree created by the parser.

**Tokens:**
The tokens generated by the lexer.

**Errors:**
If any lexing / parsing or compiler errors occur, they will be shown here.

**Disassembler:**
Shows a disassembly of the script. Note, even an "empty" script will generate bytecode as the core library for ObjoScript is implemented in ObjoScript and is prepended to your script before execution.

**Debugger:** 
The debugger is basic at present but allows you to step through code. To use it click the _step-in_ button (looks like a downwards arrow). This will advance the VM a single line of code. The debugger panel shows local variables and fields in scope and the panel at the bottom left of the window shows the VM's stack. helpfully, the editor will highlight the current line of code being stepped into.

You can spawn new IDE windows from the menu (`File > New`).

## Test suite
You can show the test suite window from the `Window > Tests` menu. To run the tests click the "Run" button or press `Cmd-R`. The tests will run to completion (takes about 20 - 30 seconds) and report if they passed or not. The source code for each test is also visible in the window.

[repo contents]: https://github.com/gkjpettet/ObjoScript/wiki/Contents-of-the-Repository