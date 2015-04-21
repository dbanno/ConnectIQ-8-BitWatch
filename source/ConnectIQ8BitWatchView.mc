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
	var isSleep;
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
        
        var hour = clockTime.hour;
        //12-hour support
        if (hour > 12 || hour == 0)
        {
	        var deviceSettings = Sys.getDeviceSettings();
	        if (!deviceSettings.is24Hour) {
	        	if (hour == 0) {
	        		hour = 12;
	        	}
	        	else {
	        		hour = hour - 12;
	        	}
	        }
        }
        var minute = clockTime.min.toString();
        if (minute.toNumber() < 10) {
        	minute = "0" + minute;
        }
        var timeString = Lang.format("$1$:$2$", [hour, minute]);

      //  var view = View.findDrawableById("TimeLabel");
       // view.setFont(font);
        //view.setText(timeString);
		dc.setColor(Gfx.COLOR_WHITE, Gfx.COLOR_TRANSPARENT);
        dc.drawText(screenX/2, 10 , font, timeString, Gfx.TEXT_JUSTIFY_CENTER);
        
    //Move Bar Hearts
        var activity = Act.getInfo();
        var moveBar = activity.moveBarLevel;
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
        
        //Show battery info when Awake
        if(isSleep == 0){ 
	    	var stats = Sys.getSystemStats();
	      	var battery = stats.battery;
	      	//Change color depending on charge	
	      	if (battery >= 50){
	      		dc.setColor(Gfx.COLOR_GREEN, Gfx.COLOR_TRANSPARENT);
	  		}
	      	else if ( (battery >= 25) && (battery < 50)){
	      		dc.setColor(Gfx.COLOR_YELLOW, Gfx.COLOR_TRANSPARENT);
	      	}else{
	      		dc.setColor(Gfx.COLOR_RED, Gfx.COLOR_TRANSPARENT);
	  		}
	  		//Large Battery Rectangle
	  		dc.drawRectangle((screenX-100), screenY-30,90,29);
	  		//Positive battery Terminal
	  		dc.drawRectangle((screenX-11), screenY-20,5,10);
	  		//Battery %
	        dc.drawText((screenX-60), screenY-30, Gfx.FONT_MEDIUM, battery.format("%4.2f") + "%", Gfx.TEXT_JUSTIFY_CENTER);
    	}
    	else {
    		var date = Time.Gregorian.info(Time.now(),0);
    		var month = date.month;
    		var day = date.day;
    		dc.setColor(Gfx.COLOR_WHITE, Gfx.COLOR_TRANSPARENT);
    		dc.drawText((screenX-40), screenY-30, Gfx.FONT_MEDIUM, month + "/" + day, Gfx.TEXT_JUSTIFY_CENTER);
    	}

        
    }

    //! The user has just looked at their watch. Timers and animations may be started here.
    function onExitSleep() {
    	isSleep = 0;
	}
    //! Terminate any active timers and prepare for slow updates.
    function onEnterSleep() {
    	isSleep = 1;
    }

}