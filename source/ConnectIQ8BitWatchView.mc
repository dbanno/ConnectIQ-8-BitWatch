using Toybox.WatchUi as Ui;
using Toybox.Graphics as Gfx;
using Toybox.System as Sys;
using Toybox.Lang as Lang;
using Toybox.ActivityMonitor as Act;

class ConnectIQ8BitWatchView extends Ui.WatchFace {

	var font;
	var halfHeart;
	var fullHeart;
	var emptyHeart;
    //! Load your resources here
    function onLayout(dc) {
        //setLayout(Rez.Layouts.WatchFace(dc));
        font = Ui.loadResource(Rez.Fonts.id_font_Retro);
        halfHeart = Ui.loadResource(Rez.Drawables.id_HalfHeart);
        fullHeart = Ui.loadResource(Rez.Drawables.id_FullHeart);
        emptyHeart = Ui.loadResource(Rez.Drawables.id_EmptyHeart);
    }

    //! Restore the state of the app and prepare the view to be shown
    function onShow() {
    }

    //! Update the view
    function onUpdate(dc) {
    	// Call the parent onUpdate function to redraw the layout
        View.onUpdate(dc);
        // Get and show the current time
		dc.setColor(Gfx.COLOR_BLACK, Gfx.COLOR_BLACK);
        dc.clear();
        
        var screenY = dc.getHeight();
        var screenX = dc.getWidth();
        var clockTime = Sys.getClockTime();
        var timeString = Lang.format("$1$:$2$", [clockTime.hour, clockTime.min.format("%.2d")]);
      //  var view = View.findDrawableById("TimeLabel");
       // view.setFont(font);
        //view.setText(timeString);
		dc.setColor(Gfx.COLOR_WHITE, Gfx.COLOR_TRANSPARENT);
        dc.drawText(10, 10 , font, timeString, Gfx.TEXT_JUSTIFY_LEFT);
        
        var activity = Act.getInfo();
        var moveBar = activity.moveBarLevel.toNumber();
        if(moveBar == 0) {
        	dc.drawBitmap(10,screenY-30,fullHeart);
        	dc.drawBitmap(35,screenY-30,fullHeart);
        	dc.drawBitmap(60,screenY-30,fullHeart);
        }
        else if(moveBar == 1) {
        	dc.drawBitmap(10,screenY-30,fullHeart);
        	dc.drawBitmap(35,screenY-30,fullHeart);
        	dc.drawBitmap(60,screenY-30,halfHeart);
        }
        else if(moveBar == 2) {
        	dc.drawBitmap(10,screenY-30,fullHeart);
        	dc.drawBitmap(35,screenY-30,fullHeart);
        	dc.drawBitmap(60,screenY-30,emptyHeart);
        }
        else if(moveBar == 3) {
        	dc.drawBitmap(10,screenY-30,fullHeart);
        	dc.drawBitmap(35,screenY-30,halfHeart);
        	dc.drawBitmap(60,screenY-30,emptyHeart);
        }
        else if(moveBar == 4) {
        	dc.drawBitmap(10,screenY-30,fullHeart);
        	dc.drawBitmap(35,screenY-30,emptyHeart);
        	dc.drawBitmap(60,screenY-30,emptyHeart);
        }
        else if(moveBar == 5) {
        	dc.drawBitmap(10,screenY-30,emptyHeart);
        	dc.drawBitmap(35,screenY-30,emptyHeart);
        	dc.drawBitmap(60,screenY-30,emptyHeart);
        }
       // dc.drawText(,Gfx.FONT_LARGE, ,Gfx.TEXT_JUSTIFY_LEFT);

        
    }

    //! The user has just looked at their watch. Timers and animations may be started here.
    function onExitSleep() {
    }

    //! Terminate any active timers and prepare for slow updates.
    function onEnterSleep() {
    }

}