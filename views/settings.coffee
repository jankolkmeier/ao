form method:'post', action:"/settings/save", id:'settingsForm', ->
    div ->
        h3 "General"
        div "Scenario URI"
        input type:'text', class:'editsettings scenarioUri', name:'scenarioUri',
            placeholder:'http://server.com/scenario.json', value:"#{@settings?.scenarioUri or ''}"

        h3 "Payoff Settings"
        div "Factor of degradation of impact of tasks done in past per day"
        input type:'text', class:'editsettings payoffDegradationPerDay', name:'payoffDegradationPerDay',
            placeholder:'0.1', value:"#{@settings?.payoffDegradationPerDay or ''}"

        h3 "Mail notifications"
        div "Mail Host"
        input type:'text', class:'editsettings mailHost', name:'mailHost',
            placeholder:'smtp.server.com', value:"#{@settings?.mailHost or ''}"
        div "Mail Port"
        input type:'text', class:'editsettings mailPort', name:'mailPort',
            placeholder:'465', value:"#{@settings?.mailPort or ''}"
        div "Mail Domain"
        input type:'text', class:'editsettings mailDomain', name:'mailDomain',
            placeholder:'localhost', value:"#{@settings?.mailDomain or ''}"
        div "Mail From"
        input type:'text', class:'editsettings mailFrom', name:'mailFrom',
            placeholder:'user@server.com', value:"#{@settings?.mailFrom or ''}"
        div "Mail User"
        input type:'text', class:'editsettings mailUser', name:'mailUser',
            placeholder:'user@server.com', value:"#{@settings?.mailUser or ''}"
        div "Mail Password"
        input type:'password', class:'editsettings mailPass', name:'mailPass',
            placeholder:'password', value:"#{@settings?.mailPass or ''}"
        div "Mail SSL"
        if @settings?.mailSSL
            input type:'checkbox', class:'editsettings mail', name:'mailSSL', value:"ssl", checked:"yes"
        else
            input type:'checkbox', class:'editsettings mail', name:'mailSSL', value:"ssl", unchecked:"yes"
        h3 "Other"
        div "..."
        input type:'submit', value:'Save'
