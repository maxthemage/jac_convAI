node state {
    has title;
    has message;
    has prompts;
}

edge transition {
    has intent;
}

graph main_graph {

    has anchor main_root;

    spawn {
        
        main_root = spawn node::state(
                                title="Greeting", 
                                message="Hi, welcome to V75. What would you like to build today?", 
                                prompts=["website", "mobile app", "information system", "quit"]
                            );

        quit_node = spawn node::state(title="Quit", message="quitting...", prompts="");

        website = spawn main_root -[transition(intent="website")]-> node::state(
                                title="Website",
                                message="What kind of website would you like to build?",
                                prompts=["one-pager", "5-page", "other", "back"]
                            );

        website -[transition(intent="back")]-> main_root;
        
        one_pager = spawn website -[transition(intent="one-pager")]-> node::state(
                        title="One Pager",
                        message="Tell us about the one pager you'd like to build",
                        prompts=["back"]
                    );
        
        one_pager -[transition(intent="back")]-> website;

        five_pager = spawn website -[transition(intent="5-page")]-> node::state(
                        title="5 Pager",
                        message="Tell us about the 5 pager you'd like to build",
                        prompts=["back"]
                    );

        five_pager -[transition(intent="back")]-> website;
                
        other = spawn website -[transition(intent="other")]-> node::state(
                        title="Other",
                        message="Tell us about the custom website you'd like to build",
                        prompts=["back"]
                    );
        
        other -[transition(intent="back")]-> website;

        main_root -[transition(intent="quit")]-> quit_node;
        
        mobile_app = spawn main_root -[transition(intent="mobile app")]-> node::state(
                        title="Mobile App",
                        message="What kind of mobile app would you like to build?",
                        prompts=["game", "social", "other", "back"]
                    );

        mobile_app -[transition(intent="back")]-> main_root;

        game = spawn mobile_app -[transition(intent="game")]-> node::state(
                        title="Game",
                        message="Tell us about the game you would like to build",
                        prompts=["back"]
                    );
        
        game -[transition(intent="back")]-> mobile_app;

        social = spawn mobile_app -[transition(intent="social")]-> node::state(
                        title="Social",
                        message="Tell us about the social media app you would like to build",
                        prompts=["back"]
                    );

        social -[transition(intent="back")]-> mobile_app;

        other_mobile_app = spawn mobile_app -[transition(intent="other")]-> node::state(
                        title="Other Mobile App",
                        message="Tell us about the custom app you would like to build",
                        prompts=["back"]
                    );
        
        other_mobile_app -[transition(intent="back")]-> mobile_app;

        info_sys = spawn main_root -[transition(intent="information system")]-> node::state(
                        title="Information System",
                        message="Tell us about the information system you'd like to build",
                        prompts=["back"]
                    );   
        
        info_sys -[transition(intent="back")]-> main_root;

    }

}