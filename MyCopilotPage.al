page 50100 MyCopilotPage
{
    Caption = 'Draft new job with Copilot';

    // Show the natural language user input as caption
    DataCaptionExpression = UserInput;

    PageType = PromptDialog; 
    PromptMode = Prompt; // Specify the starting prompt mode. Default value is Prompt.
    IsPreview = true;

    // You can have a source table for a PromptDialog page, as long as the source table is temporary. This is optional, though. 
    // The meaning of this source table is slightly different than for the other page types. In a PromptDialog page, the source table should represent an
    // instance of a copilot suggestion, that can include both the user inputs and the Copilot results. You should insert a new record each time the user
    // tries to regenerate a suggestion (before the page is closed and the suggestion saved). This way, the Business Central web client will show a new
    // history control, that allows the user to go back and forth between the different suggestions that Copilot provided, and choose the best one to save.
    
    SourceTable = TempInputData;
    SourceTableTemporary = true;
    
    Extensible = false; // Mandatory setting to ensure that the page isn't extended so that customers can trust the AI experience implemented.

    layout
    {
        // In PromptDialog pages, you can define a PromptOptions area. Here you can add different settings to tweak the output that Copilot will generate.
        // These settings must be defined as page fields, and must be of type Option or Enum. You cannot define groups in this area.

        // The Prompt area is where the user can provide input for your Copilot feature. The PromptOptions area should contain fields that have a limited set of options,
        // whereas the Prompt area can contain more structured and powerful controls, such as free text controls and subparts with grids.

        area(Prompt) 
        { 

            /* The input to copilot. Accepts any control, except repeater controls. */ 

            field(ProjectDescription; UserInput)
            {    
                ShowCaption = false;
                MultiLine = true;
            }
        }
    
        // The Content area is the output of the Copilot feature. This can contain fields or parts, so that you can have all the flexibility you need to
        // show the user the suggestion that your Copilot feature generated.

        area(Content) 
        { 
            /* The output of copilot. Accepts any control, except repeater controls. */ 

            field("Job Short Description"; JobDescription)
            {...}

            field("Job Full Details"; JobFullDescription)
            {...}

            field(CustomerNameField; CustomerName)
            {...}        
    
            part(ProposalDetails; "Copilot Job Proposal Subpart")        
            [...]
        }

        area(PromptOptions) 
        { 
            /*The input options. Only accepts option fields.*/ 
            
            field(Tone; Tone)  {}
    
            field(TextFormat; TextFormat)  {}
        
            field(Emphasis; Emphasis)  {}

        }
    }

    actions
    {
        area(SystemActions)
        {
            // Pre-defined system actions (Generate, Regenerate, Attach, Ok, or Cancel). Can only use system actions on this page.

            // You can have custom behavior for the main system actions in a PromptDialog page, such as generating a suggestion with copilot, regenerate, or discard 
            // the suggestion. When you develop a Copilot feature, remember: the user should always be in control (the user must confirm anything Copilot suggests 
            // before any change is saved).
            // This is also the reason why you cannot have a physical SourceTable in a PromptDialog page (you either use a temporary table, or no table).

            systemaction(Generate)
            {
                Caption = 'Generate'; 
                ToolTip = 'Generate using copilot';

                trigger OnAction()
                begin
                    // The code triggering the copilot interaction.
                    RunGeneration();
                end;
            }

            systemaction(Ok)
            {   
                // The Caption and Tooltip of system actions can be modified.
                Caption = 'Keep it'; 
                ToolTip = 'Save the job proposal';
            }

            systemaction(Cancel)
            {
                // The Caption and Tooltip of system actions can be modified.
                Caption = 'Throw away'; 
                ToolTip = 'Throw away the job proposal and start over';
            }

            systemaction(Regenerate)
            {    
                Caption = 'Regenerate';
                ToolTip = 'Regenerate the job proposal';
                
                trigger OnAction()
                begin
                    RunGeneration();
                end;
            }
        }
    }

    // Respect the user's choice
    trigger OnQueryClosePage(CloseAction: Action): Boolean 
    var SaveCopilotJobProposal: Codeunit "Save Copilot Job Proposal";
    begin
        if CloseAction = CloseAction::OK then
            SaveCopilotJobProposal.Save(CustomerNo, CopilotJobProposal);
    end;


    trigger OnInit()
    begin
        // The prompt mode can be changed at runtime.
        // CurrPage.PromptMode := PromptMode::Generate;
    end;
}
