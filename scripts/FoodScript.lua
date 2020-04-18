say("What is that food you're eating?", "p", "r", "n", false)
say("No idea -- I'm just happy to be eating it!", "j", "l", "n", false)
say("Oh ... alright.", "p", "r", "n", false)
ask("Would you be interested in some pasta? I found this nice recipe on Bon Appetit...", "p", "r", "n", false,
    {"Sure!", "I'm a blob of pixels, honey."},
    {
        function () 
            say("Cool. It's hard to cook when it's just me in this apartment. Let me take you into the kitchen.", "p", "r", "n", false) 
        end,
        function () 
            say("Of course. What am I doing? Next I'll be asking you out for drinks!", "p", "r", "n", false)
            say("I do like a nice glass of Cava. Oh and now I'm of age!", "j", "l", "n", false)
            say("Hahahaha okay let's do it. When the bars reopen.", "p", "r", "n", false)
            ask("But I find it so hard to cook when I'm all alone... like what's the point of making something nice if no one else can enjoy it?", "p", "r", "n", false,
            {"So you can enjoy it!", "I guess I wouldn't understand."},
            {
                function () 
                    say("So you can enjoy it of course! There's nothing wrong in making something for you. I say go make it. Maybe I'll try some.", "j", "l", "n", false) 
                end,
                function () 
                    say("I guess you wouldn't.", "p", "r", "n", false) 
                end
            })     
        end
    }
)
say("How's it going?", "j", "l", "n", false)
ask("Good. This is actually really easy once I get up and do it.", "p", "r", "n", false, 
    {
        "What have you been doing to pass the time?",
        "Do you have a favorite food you cook for others?"
    },
    {
        function () 
            say("Feeling sorry for myself, mostly.", "p", "r", "n", false)
            say("[redacted] broke up with me only days before the state shut down everything, and I was spending those days locked up in my room like I was already quarantined.", "p", "r", "n", false)
            say("Rough.", "j", "l", "n", false)
            ask("I was just about ready to go out and face the world again when suddnely it was unsafe for me to do so.", "p", "r", "n", false,
                {
                    "You think I could get sick?",
                    "You're not sick, are you?"
                },
                {
                    function () say("Depends if you can actually eat this pasta.", "p", "r", "n", false) end,
                    function () say("Wouldn't you like to know!", "p", "r", "n", false) end
                }
            )
            say("So anyways, it's been such a cold April, I've just been staring out the window all day and thinking about how me and [redacted] used to go swimming around here.", "p", "r", "n", false)
            ask("And now, I'll never swim with him again! and lord knows when I'll be able to swim again at all!", "p", "r", "n", false,
                {
                    "Well, you can take this time to learn more about being by yourself.",
                    "I'm sorry. I guess things out there are just shitty sometimes."
                },
                {
                    function ()
                        say("I know I'm bad at being alone! Getting better at that isn't like learning how to knit!", "p", "r", "n", false)
                        addprop("burned")
                        say("Oh fuck!", "p", "r", "n", true)
                        ask("I just dropped you on the stove burner. Are you alright?", "p", "r", "n", false,
                            {
                                "Yes",
                                "No"
                            },
                            {
                                function () say("I'm really sorry. I won't do anything like that again.", "p", "r", "n", false) end,
                                function () say("I'm really sorry. I won't do anything like that again.", "p", "r", "n", false) end
                            }
                        )
                    end,
                    function ()
                        say("Tell me about it.", "p", "r", "n", false)
                    end
                }
            )
        end,
        function ()
            say("Oh I like making curry the most. You just put the paste in with coconut milk and whatever ingredients you have, and your friends act like you're a genius!", "p", "r", "n", false)
            say("What's curry?", "j", "l", "n", false)
            say("Nevermind.", "p", "r", "n", false)
        end
    })
say("Look at that! Food's ready.", "p", "r", "n", false)
ask("Do you want any?", "p", "r", "n", false,
    {
        "Yes",
        "No"
    },
    {
        function () 
            say("Okay... how is this going to work?", "p", "r", "n", false) 
            say("Aim for my mouth!", "j", "l", "n", false)
            addprop("sauce")
            say("hahahahaha", "p", "r", "n", true)
            say("hahahahaha", "j", "l", "n", false)
            say("I don't know what I was expecting.", "p", "r", "n", false)
        end,
        function ()
            say("I guess you are... a videogame.", "p", "r", "n", false)
            say("More importantly, a celiac videogame!", "j", "l", "n", false)
            say("Oh! Sorry.", "p", "r", "n", false)
        end
    }
)