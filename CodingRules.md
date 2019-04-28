# AL Coding Rules - RECAP PAGE

# 1 - Best Practices for AL
This page defines some of the best practices to follow when writing AL code for Dynamics 365 Business Central. These best practices are additional to rules and guidelines that are caught during compilation of AL code. We recommend following these best practices when developing extensions in AL to ensure consistency and discoverability on file, object, and method naming, as well as better readability of written code.

# ALL TOPICS
# Extension structure
An extension is fully contained in a single folder. This folder often contains multiple files, such as app.json and launch.json files, perhaps an image file representing the extension's logo, various folders for source; "\src", other resources; "\res", and a test folder; "\test" folder. The extension does not need to follow a flat structure, which means that, depending on the amount of application files, additional folders can be used in the "src" or "test" folders to group objects based on their functionality, which can help make maintaining a large .al project easier.

# File naming
Each file name must start with the corresponding type and ID, followed by a dot for full objects or a dash for extensions. The name of the object is written only with characters [A-Za-z0-9] and dot al is used for the file type.

Follow the syntax for file naming as shown below:
Full objects	Extensions
<Type><Id>.<ObjectName>.al	<Type><BaseId>-Ext<ObjectId>.<ObjectName>.al

# Object Abbreviation
Page	Pag
Page Extension	PagExt
Page Customization	PagCust
Codeunit	Cod
Table	Tab
Table Extension	TabExt
XML Port	Xml
Report	Rep
Query	Que
Enum	Enu
Enum Extension	EnuExt
Control Add-ins	ConAddin

# Examples of file naming
The following table illustrates how the file naming should look.

Object name	File name
codeunit 1000 "Job Calculate WIP"	Cod1000.JobCalculateWIP.al
page 21 "Customer Card"	Pag21.CustomerCard.al
page 1234 "MyPag" extends "Customer Card"	Pag21-Ext1234.MyPag.al

# Formatting
We recommend keeping your AL code properly formatted as follows:

Use all lowercase letters for reserved language keywords. Built-in methods and types are not included in this rule because they are written using Pascal case.
Use four spaces for indentation.
Curly brackets are always on a new line. If there is one property, put it on a single line.

The following example illustrates these formatting rules.
page 123 PageName
{
    actions
    {
        area(Processing)
        {
            action(ActionName)
            {
                trigger OnAction()
                begin
                end;
            }
        }
    }

    var
        TempCustomer: Record Customer temporary;

    [EventSubscriber(ObjectType::Page, Page::"Item Card", 'OnAfterGetCurrRecordEvent', '', false, false)]
    local procedure OnOpenItemCard(var rec: Record Item)
    var
        OnRecord: Option " ", Item, Contact;
    begin
        EnablePictureAnalyzerNotification(rec."No.", OnRecord::Item);
    end;
}

# Line length
In general, there is no restriction on line length, but lengthy lines can make the code unreadable. We recommend that you keep your code easily scannable and readable.

# Object naming
Object names are prefixed. They start with the feature/group name, followed by the logical name as in these two examples:
Intrastat extension validation codeunit for Denmark
codeunit 123 "IntrastatDK Validation"

# File structure
Inside an .al code file, the structure for all objects must follow the sequence below:

Properties
Object-specific constructs such as:
Table fields
Page layout
Actions
Global variables
Labels (old Text Constants)
Global variables
Methods

# Referencing
In AL, objects are referenced by their object name, not by their ID.
Example

Page.RunModal(Page::"Customer Card", ...)
 
var
    Customer: Record Customer;
    
# Variable naming
For variables they must:

Be named using PascalCase.
Have the Temp prefix if they are temporary variables.
Include the object name in the name (for objects).

Example
TempCustomer: Record Customer temporary;
Vendor: Record Vendor; 

# Method declaration
To declare a method, follow the guidelines below:

Include a space after a semicolon when declaring multiple arguments.
Semicolons can be used at the end of the signature/method header. If you use a snippet, the semicolons are not automatically added.
Methods are named as variables using Pascal case. However, this is not a mandatory rule.
There must be a blank line between method declarations. If you format your code using the AL Formatter tool, the auto-formatter sets the blank line between procedures.

Example
local procedure MyProcedure(Customer: Record Customer; Int: Integer)
begin
end;

// space

local procedure MyProcedure2(Customer: Record Customer; Int: Integer)
begin
end;

# Calling methods
When calling a method, include one space after each command if you are passing multiple parameters. Parentheses must be specified when you are making a method call or system call such as: Init(), Modify(), Insert() etc.

Example
MyProcedure();
MyProcedure(1);
MyProcedure(1, 2);

# Type definition (colon)
When declaring a variable or a parameter, the name of that variable or parameter must be immediately followed by a colon, then a single space, and then the type of the variable/parameter as illustrated in the example below.

Var
    Number: Integer;
local procedure MyProcedure(a: Integer; b: Integer): Integer 
    
-------------------------------------------------------------------------------------------------------------------------------

# 2 - Enabling code analysis
First, create a simple project in AL.

Press Alt + A, Alt + L to create a new project.
Open the Command Palette Ctrl+Shift+P and choose either User Settings or Workspace Settings.
Copy the setting al.enableCodeAnalysis to the settings file and set it to true: "al.enableCodeAnalysis": true.
At this point, the analyzers packaged with the AL Language extensions will be run on your project. Next, add some code to the project that will, in the following example, be used to demonstrate a violation of the AA0001 "There must be exactly one space character on each side of a binary operator such as := + - AND OR =." code analysis rule.

Code test
"AA0001" "There must be exactly one space character on each side 

pageextension 50100 CustomerListExt extends "Customer List"
{
    trigger OnOpenPage();
    var
        result: Integer;
    begin        
        // The following line will trigger the warning
        // AA0001 "There must be exactly one space character on each side 
        // of a binary operator such as := + - AND OR =." 
        result := 2+2; 
        Message('2 + 2 = ' + Format(result));
    end;
}

# Selecting code analyzers to run
By default, all the analyzers that ship with the Visual Studio Code extension are enabled. To selectively enable code analyzers:

Open the Command Palette using the Ctrl+Shift+P shortcut and choose either User Settings or Workspace Settings.
Copy the setting al.codeAnalyzers to the settings file and set it to an empty array: "al.codeAnalyzers": [].
Add to the array the paths to the code analyzer assemblies that you want to run.
The analyzers that are shipped with the AL Language extension are available through the following variables:

"${AppSourceCop}"
"${CodeCop}"
"${PerTenantExtensionCop}"
"${UICop}"

# Viewing the results of the code analysis
The code analysis tools will run in the background. You will see the faulty expression underlined and the warning "There must be exactly one space character on each side of '+'." will be displayed if you mouse over the underlined code. You can also view the list of issues by selecting the View tab of Visual Studio Code and choosing the Problems option.

Using the Ctrl+Shift+B shortcut to build your project will run the code analysis tools on the entire project and the detected issues will be displayed in the Output window of Visual Studio Code.

-------------------------------------------------------------------------------------------------------------------------------

# 3 - Prexif/Suffix General Rules
•	The prefix/suffix must be at least 3 characters
•	The object/field name must start or end with the prefix/suffix
•	If a conflict arises, the one who registered the prefix/suffix always wins
•	For your own pages/tables/codeunits, you must set the prefix/suffix at the top object level
•	For pages/tables in the base application of Business Central that you extend, you must set the prefix/suffix at the top object level
•	For pages/tables of Business Central in the base application that you extend, you must also set at the control/field/action level
Examples of acceptable prefix/suffix:
No Delimiter
•	FABSalespersonCode
•	SalespersonCodeFAB
Space
•	"FAB Salesperson Code"
•	"Salesperson Code FAB"
Underscore
•	FAB_Salesperson_Code
•	Salesperson_Code_FAB


-------------------------------------------------------------------------------------------------------------------------------

# 4 - Technical Validation Checklist
The following is a checklist of all requirements that you must meet before submitting an extension for validation. If you do not meet these mandatory requirements, your extension will fail validation.
Enabling code analysis
1.	Press Alt + A, Alt + L to create a new project.
2.	Open the Command Palette Ctrl+Shift+P and choose either User Settings or Workspace Settings.
3.	Copy the setting al.enableCodeAnalysis to the settings file and set it to true: "al.enableCodeAnalysis": true.


-------------------------------------------------------------------------------------------------------------------------------

# 5 - Business Central Courses
https://community.dynamics.com/365/b/learningcurriculum/archive/2019/02/22/list-of-courses-available-for-download
