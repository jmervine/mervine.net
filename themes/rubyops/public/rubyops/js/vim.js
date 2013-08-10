function go(val) { $("html, body").animate({ scrollTop: val }, 200); }
function vimUp() { go($(window).scrollTop()-100); }
function vimDown() { go($(window).scrollTop()+100); }
function vimTop() { go(0); }
function vimBot() { go($('html').height()); }
function vimPageUp() { go($(window).scrollTop()-$(window).height());}
function vimPageDown() {go($(window).scrollTop()+$(window).height());}
function vimHalfUp() { go($(window).scrollTop()-($(window).height()/2));}
function vimHalfDown() {go($(window).scrollTop()+($(window).height()/2));}
function vimSearch(name) { setTimeout(function() {$(name).focus(); }, 250); }

$(window).load( function () {
    var gTimes = 0;
    $(window).keypress(function(event) {
        switch (event.keyCode) {
            case 106: vimDown(); break;
            case 107: vimUp(); break;
            case 71: vimBot(); break;
            case 70: vimPageDown(); break;
            case 66: vimPageUp(); break;
            case 85: vimHalfUp(); break;
            case 68: vimHalfDown(); break;
            case 47: vimSearch('form#searchform input#searchbox'); break;
            case 103:
                if (gTimes === 1) {
                    gTimes = 0;
                    vimTop();
                } else {
                    gTimes = 1;
                    setTimeout(function () { gTimes = 0; }, 1000);
                }
                break;
            default:
                console.log(event.keyCode);
        }
        return;
    });
});
