var searchElement = 'form#searchform input#searchbox';

function go(val) {
    if(ready){
        ready=false;
        $("html, body").animate({ scrollTop: val}, 200);
        setTimeout(function(){ ready=true; },250);
    }
}

function search() {
    if (typeof searchElement!=='undefined') {
        setTimeout(function() { $(searchElement).focus(); }, 250);
    }
}
var ready=true,
    g=0,
    vim = {
        106: function(){ go($(window).scrollTop()+100); },
        107: function(){ go($(window).scrollTop()-100); },
         71: function(){ go($('html').height()); },
         70: function(){ go($(window).scrollTop()+$(window).height());},
         66: function(){ go($(window).scrollTop()-$(window).height());},
         85: function(){ go($(window).scrollTop()-($(window).height()/2));},
         68: function(){ go($(window).scrollTop()+($(window).height()/2));},
         47: function(){ setTimeout(function() { $(searchElement).focus(); },250); },
        103: function(){ if (g===1) {
            g=0;
            go(0);
        } else { g=1;
            setTimeout(function(){g=0;},1000);}
        }
    };

$(window).load(function(){
    $(window).keypress(function(event){
        if (vim[event.keyCode]){
            vim[event.keyCode]();
        }
    });
});
