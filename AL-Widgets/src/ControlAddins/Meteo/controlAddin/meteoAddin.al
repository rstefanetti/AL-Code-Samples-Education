controladdin MeteoAddin
{
    RequestedHeight = 300;
    MinimumHeight = 300;
    MaximumHeight = 300;
    RequestedWidth = 700;
    MinimumWidth = 400;
    MaximumWidth = 700;
    VerticalStretch = true;
    VerticalShrink = true;
    HorizontalStretch = true;
    HorizontalShrink = true;

    StartupScript = 'src\ControlAddins\Meteo\js\main.js';

    // SCRIPT Plugin
    Scripts =

            'https://code.jquery.com/jquery-3.6.0.min.js',// jquery  
            'src\ControlAddins\Meteo\js\meteo.js'
        ;


    // includo i css da cdn per evitare di scaricarli in locale
    StyleSheets = 'https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css',// bootstrap                      
                    'https://pro.fontawesome.com/releases/v5.10.0/css/all.css';// fontawesome


    event controlAddinReady()

    procedure MyProcedure()
}