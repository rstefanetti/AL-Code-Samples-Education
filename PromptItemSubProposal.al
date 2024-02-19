page 54324 “Copilot Item Sub Proposal”

{

    PageType = PromptDialog;

    Extensible = false;    

    IsPreview = true;

    Caption = ‘Suggest item substitutions with Copilot’;

    // PromptMode = Content;

    // With PromptMode you can choose if the “PromptDialog” will open in:

    // – Prompt mode (ask the user for input)

    // – Generate mode (it will call the Generate system action the moment the page opens)

    // – Content mode ()

    // You can also programmaticaly set this property by setting the variable CurrPage.PromptMode before the page is opened.

    // SourceTable = ;

    // SourceTableTemporary = true;

    // You can have a source table for a PromptDialog page, as long as the source table is temporary. This is optional, though.

    // The meaning of this source table is slightly different than for the other page types. In a PromptDialog page, the source table should represent an

    // instance of a copilot suggestion, that can include both the user inputs and the Copilot results. You should insert a new record each time the user

    // tries to regenerate a suggestion (before the page is closed and the suggestion saved). This way, the Business Central web client will show a new

    // history control, that allows the user to go back and forth between the different suggestions that Copilot provided, and choose the best one to save.

local procedure GetFinalUserPrompt(InputUserPrompt: Text) FinalUserPrompt: Text

    var

        Item: Record Item;

        Newline: Char;

    begin

        Newline := 10;

        FinalUserPrompt := ‘These are the available items:’ + Newline;

        if Item.FindSet() then

            repeat

                FinalUserPrompt +=

                    ‘Number: ‘ + Item.”No.” + ‘, ‘ +

                    ‘Description:’ + Item.Description + ‘.’ + Newline;

            until Item.Next() = 0;

        FinalUserPrompt += Newline;

        FinalUserPrompt += StrSubstNo(‘The description of the item that needs to be substituted is: %1.’, InputUserPrompt);

    end;

    local procedure GetSystemPrompt() SystemPrompt: Text

    var

        Item: Record Item;

    begin

        SystemPrompt += ‘The user will provide an item description, and a list of other items. Your task is to find items that can substitute that item.’;

        SystemPrompt += ‘Try to suggest several relevant items if possible.’;

        SystemPrompt += ‘The output should be in xml, containing item number (use number tag), item description (use description tag), and explanation why this item was suggested (use explanation tag).’;

        SystemPrompt += ‘Use items as a root level tag, use item as item tag.’;

        SystemPrompt += ‘Do not use line breaks or other special characters in explanation.’;

        SystemPrompt += ‘Skip empty nodes.’;

    end;

    var

        TmpItemSubstAIProposal: Record “Copilot Item Sub Proposal” temporary;

        UserPrompt: Text;
}
