#include duffman\_common;

init( modVersion )
{
	level.fullbrightkey = "8";
	level.fovkey = "9";
	level.knifekey = "5";
	//level.dotkey = "7";
	
	addConnectThread(::onPlayerConnected);
	addSpawnThread(::onPlayerSpawn);
}
 
onPlayerConnected()
{
	if(!isDefined(self.pers["fb"]))
		self.pers["fb"] = self getstat(1222);
	if(!isDefined(self.pers["fov"]))
		self.pers["fov"] = self getstat(1322);
	//if(!isDefined(self.pers["dot"]))
	//	self.pers["dot"] = self getstat(1600);
	if(!isDefined(self.pers["knifeMusic"]))
		self.pers["knifeMusic"] = self getstat(1601);
	if(!isDefined(self.pers["killCamMusic"]))
		self.pers["killCamMusic"] = self getstat(1602);
	if(!isDefined(self.pers["so_hiticon"]))
		self.pers["so_hiticon"] = self getstat(3152);
	if(!isDefined(self.pers["so_killcam_style"]))
		self.pers["so_killcam_style"] = 1;
	if(!isDefined(self.pers["so_killcard"]))
		self.pers["so_killcard"] = 1;
	if(!isDefined(self.pers["so_advertisement"]))
		self.pers["so_advertisement"] = 0;
	if(!isDefined(self.pers["so_dPop"]))
		self.pers["so_dPop"] = 0;
		
	self thread ToggleBinds();
	self thread Nodify();
	
	if(self.pers["fb"] == 1){
		self setClientDvar( "r_fullbright", 1 );
	}
	if(self.pers["fb"] == 0){
		self setClientDvar( "r_fullbright", 0 );
	}
	
	if(self.pers["fov"] == 1){
		self setClientDvar( "cg_fovscale", 1 );
	}
	if(self.pers["fov"] == 2){
		self setClientDvar( "cg_fovscale", 1.125 );
	}
	if(self.pers["fov"] == 3){
		self setClientDvar( "cg_fovscale", 1.25 );
	}
	if(self.pers["fov"] == 4){
		self setClientDvar( "cg_fovscale", 1.3 );
	}
	if(self.pers["fov"] == 5){
		self setClientDvar( "cg_fovscale", 1.4 );
	}
	if(self.pers["fov"] == 0){
		self setClientDvar( "cg_fovscale", 1.5 );
	}
	
	//if(self.pers["dot"] == 1){
	//	self reddot();
	//}
	
	
	if(self.pers["killCamMusic"] == 1){
		self setClientDvar( "so_kill_mute", 1 );
	}
	if(self.pers["killCamMusic"] == 0){
		self setClientDvar( "so_kill_mute", 0 );
	}
	
	
	if(self.pers["knifeMusic"] == 1){
		self setClientDvar( "so_knife_mute", 1 );
	}
	if(self.pers["knifeMusic"] == 0){
		self setClientDvar( "so_knife_mute", 0 );
	}
	
	if(self.pers["so_advertisement"] == 1){
		self setClientDvar( "so_advertisement", 1 );
	}
	if(self.pers["so_advertisement"] == 0){
		self setClientDvar( "so_advertisement", 0 );
	}
	
	
	//self.pers["so_dPop"] = 0; // default ON
	if(self.pers["so_dPop"] == 0){
		self setClientDvar( "so_dPop", 0 );
	}
	if(self.pers["so_dPop"] == 1){
		self setClientDvar( "so_dPop", 1 );
	}


	if(self.pers["so_hiticon"] == 0){
		self setClientDvar( "so_hiticon", 0 );
		self setClientDvar( "so_hiticonName", "damage_feedback" );
	}
	if(self.pers["so_hiticon"] == 1){
		self setClientDvar( "so_hiticon", 1 );
		self setClientDvar( "so_hiticonName", "hit_icon_1" );
	}
	if(self.pers["so_hiticon"] == 2){
		self setClientDvar( "so_hiticon", 2 );
		self setClientDvar( "so_hiticonName", "hit_icon_2" );
	}
	if(self.pers["so_hiticon"] == 3){
		self setClientDvar( "so_hiticon", 3 );
		self setClientDvar( "so_hiticonName", "hit_icon_3" );
	}


	// if(self.pers["so_killcam_style"] == 0){
	// 	self setClientDvar( "so_killcam_style", 0 );
	// 	self setClientDvar( "so_killCamStyleSample", "killcam1" );
	// 	self setClientDvar( "so_killcamName", "Promod Default (RED) Kill-Camera" );
	// }
	if(self.pers["so_killcam_style"] == 1){
		self setClientDvar( "so_killcam_style", 1 );
		self setClientDvar( "so_killCamStyleSample", "killcam2" );
		self setClientDvar( "so_killcamName", "Promod (BLACK) Kill-Camera" );
	}
	if(self.pers["so_killcam_style"] == 2){
		self setClientDvar( "so_killcam_style", 2 );
		self setClientDvar( "so_killCamStyleSample", "killcam3" );
		self setClientDvar( "so_killcamName", "SO (Digital Camcorder) Kill-Camera" );
	}

}
onPlayerSpawn()
{

	self crazy\_common::clientCmd("bind "+level.fovkey +" openscriptmenu -1 fov");
	wait 0.1;
	self crazy\_common::clientCmd("bind "+level.fullbrightkey +" openscriptmenu -1 fps");
	wait 0.1;
	self crazy\_common::clientCmd("bind "+level.knifekey +" openscriptmenu -1 giveknife");

}
ToggleBinds()
{
	self endon("disconnect");
	
	for(;;)
	{
		self waittill("menuresponse", menu, response);
		if(response == "fps")
		{
			if(self.pers["fb"] == 0)
			{
				//self iPrintlnBOld( "FullBright ^0<^2ON^0>" );
				self setClientDvar( "r_fullbright", 1 );
				self setstat(1222,1);
				self.pers["fb"] = 1;
				quickNotify("^5FullBright","^3ON");
			}
			else if(self.pers["fb"] == 1)
			{
				//self iPrintlnBOld( "FullBright ^0<^1OFF^0>" );
				self setClientDvar( "r_fullbright", 0 );
				self setstat(1222,0);
				self.pers["fb"] = 0;
				quickNotify("^5FullBright","^2OFF");
			}
		}
		if(response == "fov")
		{	
			if(self.pers["fov"] == 0)
			{
				//self iPrintlnBOld( "FOV ^0<^11^0> ^7Low Scale" );
				self setClientDvar( "cg_fovscale", 1 );
				self setstat(1322,1);
				self.pers["fov"] = 1;
				quickNotify("^5FOV scale","^11");
			}
			else if(self.pers["fov"] == 1)
			{
				//self iPrintlnBOld( "FOV ^0<^11.125^0> ^7Recommended Scale" );
				self setClientDvar( "cg_fovscale", 1.125 );
				self setstat(1322,2);
				self.pers["fov"] = 2;
				quickNotify("^5FOV scale","^11.125");
			}
			else if(self.pers["fov"] == 2)
			{
				//self iPrintlnBOld( "FOV ^0<^11.25^0>" );
				self setClientDvar( "cg_fovscale", 1.25 );
				self setstat(1322,3);
				self.pers["fov"] = 3;
				quickNotify("^5FOV scale","^11.25");
			}
			else if(self.pers["fov"] == 3 )
			{
				//self iPrintlnBOld( "FOV ^0<^11.3^0>" );
				self setClientDvar( "cg_fovscale", 1.3 );
				self setstat(1322,4);
				self.pers["fov"] = 4;
				quickNotify("^5FOV scale","^11.3");
			}
			else if(self.pers["fov"] == 4)
			{
				//self iPrintlnBOld( "FOV ^0<^11.4^0> ^7High Scale" );
				self setClientDvar( "cg_fovscale", 1.4 );
				self setstat(1322,5);
				self.pers["fov"] = 5;
				quickNotify("^5FOV scale","^11.4");
			}
			else if(self.pers["fov"] == 5)
			{
				//self iPrintlnBOld( "FOV ^0<^11.5^0> ^7Very High Scale" );
				self setClientDvar( "cg_fovscale", 1.5 );
				self setstat(1322,0);
				self.pers["fov"] = 0;
				quickNotify("^5FOV scale","^11.5");
			}
		}
		/*if(response == "dot")
		{
			if(self.pers["dot"] == 0)
			{
				self reddot();
				self iPrintlnBOld("^1RED DOT^0 <^2ON^0>");
				//iPrintln("^5NOOB <<"+self.name+">> ^7ON  ^1RED DOT");
				self setstat(1600,1); 
				self.pers["dot"] = 1;
			}
			else if (self.pers["dot"] == 1)
			{
				self iPrintlnBOld("^1RED DOT ^0<^3OFF^0>");
				self.reddot destroy();
				//iPrintln("^5NOOB <<"+self.name+">> ^7OFF  ^1RED DOT");
				self setstat(1600,0); 
				self.pers["dot"] = 0;
			}
		}*/
		
		if(response == "knifemusic")
		{
			if(self.pers["knifeMusic"] == 0)
			{
				self setClientDvar( "so_knife_mute", 1 );
				self setstat(1601,1); 
				self.pers["knifeMusic"] = 1;
				self quickNotify("^5Knife Round Music","^2OFF");
			}
			else if (self.pers["knifeMusic"] == 1)
			{
				self setClientDvar( "so_knife_mute", 0 );
				self setstat(1601,0); 
				self.pers["knifeMusic"] = 0;
				self quickNotify("^5Knife Round Music","^3ON");
			}
		}

		if(response == "giveknife")
		{
			if(!self hasWeapon("knife_mp")){
			self giveweapon( "knife_mp");
			self switchtoweapon("knife_mp");
			self iPrintln("Gave ^1Knife");
			self iPrintLn("Press ^2["+level.knifekey +"]^7 Again To Remove Knife");
			}
			else if(self hasWeapon("knife_mp")){
			self iPrintln("Removed ^1Knife");
			self takeweapon("knife_mp");
			if (self hasWeapon("deserteagle_mp")) self switchtoweapon("deserteagle_mp");
			if (self hasWeapon("deserteaglegold_mp")) self switchtoweapon("deserteaglegold_mp");
			}
		}

		if(response == "killcammusic")
		{
			if(self.pers["killCamMusic"] == 0)
			{
				self setClientDvar( "so_kill_mute", 1 );
				self setstat(1602,1); 
				self.pers["killCamMusic"] = 1;
				self quickNotify("^5Kill Cam Music","^2OFF");
			}
			else if (self.pers["killCamMusic"] == 1)
			{
				self setClientDvar( "so_kill_mute", 0 );
				self setstat(1602,0); 
				self.pers["killCamMusic"] = 0;
				self quickNotify("^5Kill Cam Music","^3ON");
			}
		}
		
		if(response == "so_add_menu")
		{
			if(self.pers["so_advertisement"] == 0)
			{
				self setClientDvar( "so_advertisement", 1 );
				self setstat(3156,1); 
				self.pers["so_advertisement"] = 1;
				self quickNotify("^5Side Advertisement","^2OFF");
			}
			else if (self.pers["so_advertisement"] == 1)
			{
				self setClientDvar( "so_advertisement", 0 );
				self setstat(3156,0); 
				self.pers["so_advertisement"] = 0;
				self quickNotify("^5Side Advertisement","^3ON");
			}
		}
		
		if(response == "so_dPop_menu")
		{
			if(self.pers["so_dPop"] == 0)
			{
				self setClientDvar( "so_dPop", 1 );
				self setstat(3151,1); 
				self.pers["so_dPop"] = 1;
				self quickNotify("^5Damage PopUp","^2OFF");
			}
			else if (self.pers["so_dPop"] == 1)
			{
				self setClientDvar( "so_kill_mute", 0 );
				self setstat(3151,0); 
				self.pers["so_dPop"] = 0;
				self quickNotify("^5Damage PopUp","^3ON");
			}
		}
		
		if(response == "so_hitIcon")
		{
			if(self.pers["so_hiticon"] == 0)
			{
				self setClientDvar( "so_hiticon", 1 );
				self setstat(3152,1); 
				self.pers["so_hiticon"] = 1;
				self setClientDvar( "so_hiticonName", "hit_icon_1" );
				//self quickNotify("^5Damage FeedBack : ","^7AW");
			}
			else if (self.pers["so_hiticon"] == 1)
			{
				self setClientDvar( "so_hiticon", 2 );
				self setstat(3152,2); 
				self.pers["so_hiticon"] = 2;
				self setClientDvar( "so_hiticonName", "hit_icon_2" );
				//self quickNotify("^5Damage FeedBack : ","^7RED");
			}
			else if (self.pers["so_hiticon"] == 2)
			{
				self setClientDvar( "so_hiticon", 3 );
				self setstat(3152,3); 
				self.pers["so_hiticon"] = 3;
				self setClientDvar( "so_hiticonName", "hit_icon_3" );
				//self quickNotify("^5Damage FeedBack : ","^7#SO");
			}
			else if (self.pers["so_hiticon"] == 3)
			{
				self setClientDvar( "so_hiticon", 0 );
				self setstat(3152,0); 
				self.pers["so_hiticon"] = 0;
				self setClientDvar( "so_hiticonName", "damage_feedback" );
				//self quickNotify("^5Damage FeedBack : ","^7DEFAULT");
			}
		}
		
		
		if(response == "so_killcam_style_menu")
		{
			if(self.pers["so_killcam_style"] == 0)
			{
				self setClientDvar( "so_killcam_style", 1 );
				self setstat(3154,1); 
				self.pers["so_killcam_style"] = 1;
				self setClientDvar( "so_killCamStyleSample", "killcam2" );
				self setClientDvar( "so_killcamName", "Promod (BLACK) Kill-Camera" );
				//self quickNotify("^5Damage FeedBack : ","^7Promod (BLACK) Kill-Camera");
			}
			else if (self.pers["so_killcam_style"] == 1)
			{
				self setClientDvar( "so_killcam_style", 2 );
				self setstat(3154,2); 
				self.pers["so_killcam_style"] = 2;
				self setClientDvar( "so_killCamStyleSample", "killcam3" );
				self setClientDvar( "so_killcamName", "SO (Digital Camcorder) Kill-Camera" );
				//self quickNotify("^5Damage FeedBack : ","^7SO (Digital Camcorder) Kill-Camera");
			}
			else if (self.pers["so_killcam_style"] == 2)
			{
				self setClientDvar( "so_killcam_style", 3 );
				self setstat(3154,3); 
				self.pers["so_killcam_style"] = 3;
				self setClientDvar( "so_killCamStyleSample", "killcam4" );
				self setClientDvar( "so_killcamName", "SO (Fun) Kill-Camera" );
				//self quickNotify("^5Damage FeedBack : ","^7SO (Fun Sinhala) Kill-Camera");
			}
			else if (self.pers["so_killcam_style"] == 3)
			{
				self setClientDvar( "so_killcam_style", 0 );
				self setstat(3154,0); 
				self.pers["so_killcam_style"] = 0;
				self setClientDvar( "so_killCamStyleSample", "killcam1" );
				self setClientDvar( "so_killcamName", "Promod Default (RED) Kill-Camera" );
				//self quickNotify("^5Damage FeedBack : ","^7Promod Default (RED) Kill-Camera");
			}
		}
		
		
		if(response == "so_killcard_menu")
		{
			if(self.pers["so_killcard"] == 0)
			{
				self setClientDvar( "so_killcard", 1 );
				self setstat(3155,1); 
				self.pers["so_killcard"] = 1;
				self setClientDvar( "so_killCardSample", "killcard_sl" );
				self setClientDvar( "so_killcardName", "SL KillCard" );
				duffman\_killcard::setDesign("blue");
			}
			else if (self.pers["so_killcard"] == 1)
			{
				self setClientDvar( "so_killcard", 2 );
				self setstat(3155,2); 
				self.pers["so_killcard"] = 2;
				self setClientDvar( "so_killCardSample", "killcard_in" );
				self setClientDvar( "so_killcardName", "Chak De! India Kill-Card" );
				duffman\_killcard::setDesign("green");
			}
			else if (self.pers["so_killcard"] == 2)
			{
				self setClientDvar( "so_killcard", 3 );
				self setstat(3155,3); 
				self.pers["so_killcard"] = 3;
				self setClientDvar( "so_killCardSample", "killcard_ns" );
				self setClientDvar( "so_killcardName", "Racing Car Kill-Card" );
				duffman\_killcard::setDesign("black");
			}
			else if (self.pers["so_killcard"] == 3)
			{
				self setClientDvar( "so_killcard", 4 );
				self setstat(3155,4); 
				self.pers["so_killcard"] = 4;
				self setClientDvar( "so_killCardSample", "killcard_yk" );
				self setClientDvar( "so_killcardName", "Api Yakku Bolawu (Sinhala) Kill-Card" );
				duffman\_killcard::setDesign("red");
			}
			
			else if (self.pers["so_killcard"] == 4)
			{
				self setClientDvar( "so_killcard", 5 );
				self setstat(3155,5); 
				self.pers["so_killcard"] = 5;
				self setClientDvar( "so_killCardSample", "killcard_pg" );
				self setClientDvar( "so_killcardName", "Pubg Game Kill-Card" );
				duffman\_killcard::setDesign("white");
			}
			else if (self.pers["so_killcard"] == 5)
			{
				self setClientDvar( "so_killcard", 6 );
				self setstat(3155,6); 
				self.pers["so_killcard"] = 6;
				self setClientDvar( "so_killCardSample", "killcard_mw" );
				self setClientDvar( "so_killcardName", "Modern-Warfare Game Kill-Card" );
				duffman\_killcard::setDesign("yellow");
			}
			else if (self.pers["so_killcard"] == 6)
			{
				self setClientDvar( "so_killcard", 7 );
				self setstat(3155,7); 
				self.pers["so_killcard"] = 7;
				self setClientDvar( "so_killCardSample", "killcard_jk" );
				self setClientDvar( "so_killcardName", "Joker Kill-Card" );
				duffman\_killcard::setDesign("orange");
			}
			else if (self.pers["so_killcard"] == 7)
			{
				self setClientDvar( "so_killcard", 8 );
				self setstat(3155,8); 
				self.pers["so_killcard"] = 8;
				self setClientDvar( "so_killCardSample", "killcard_gl" );
				self setClientDvar( "so_killcardName", "Gaming is Life (Sinhala) Kill-Card" );
				duffman\_killcard::setDesign("brown");
			}
			else if (self.pers["so_killcard"] == 8)
			{
				self setClientDvar( "so_killcard", 9 );
				self setstat(3155,9); 
				self.pers["so_killcard"] = 9;
				self setClientDvar( "so_killCardSample", "killcard_ct" );
				self setClientDvar( "so_killcardName", "Cartoon Kill-Card" );
				duffman\_killcard::setDesign("member");
			}
			else if (self.pers["so_killcard"] == 9)
			{
				self setClientDvar( "so_killcard", 0 );
				self setstat(3155,0); 
				self.pers["so_killcard"] = 0;
				self setClientDvar( "so_killCardSample", "killcard" );
				self setClientDvar( "so_killcardName", "SO (Default) Kill-Card" );
				duffman\_killcard::setDesign("default");
			}
		}
	if( int(response) > 35 && int(response) < 67 )
	{
		character = int(response)-41;
			self setStat( 980, character );
			self setClientDvar( "drui_character", character );
			self iprintln("You have selected skin: ^1"+character);
	}
	}
}

quickNotify(msg,action){

	self endon( "disconnect" );
	
	self.title = newclientHudElem(self);
	self.title.x = -20;
	self.title.y = 120;
	self.title.alignx = "center";
	self.title.horzAlign = "center";
	self.title.sort = 1002;
	self.title.alpha = 1;
	self.title.glowalpha = 1;
	self.title.glowcolor = (0.3, 0.3, 0.3);
	self.title.glowAlpha = 2;
	self.title.fontscale = 2.4;
	self.title.foreground = false;
	self.title.hidewheninmenu = false;
	self.title setText( msg );
	
	self.happen = newclientHudElem(self);
	self.happen.x = -20;
	self.happen.y = 143;
	self.happen.alignx = "center";
	self.happen.horzAlign = "center";
	self.happen.sort = 1003;
	self.happen.alpha = 1;
	self.happen.glowalpha = 1;
	self.happen.fontscale = 2.2;
	self.happen.foreground = false;
	self.happen.hidewheninmenu = false;
	self.happen setText( "^0> "+action );
	
	//wait 0.1;
	self.title moveOverTime(0.15);
	self.title.x = 5;
	
	self.happen moveOverTime(0.15);
	self.happen.x = 0;
	wait 0.4;
	self.title destroy();
	self.happen destroy();
}

Nodify()
{
	self endon("disconnect");
	for(;;)
	{
		wait RandomInt(90)+50;
		//self iPrintln("Press ^5["+level.dotkey+"]^7 To Toggle Red DOT");
		//wait 3;
		self iPrintln("Press ^5["+level.fullbrightkey+"]^7 To Toggle FullBright");
		wait 3;
		self iPrintln("Press ^5["+level.fovkey +"]^7 To Toggle FOV");
		wait 3;
		self iPrintLn("Press ^2["+level.knifekey +"]^7 To Get Knife");
	}
}

reddot()
{
    self.reddot = newClientHudElem(self);
    self.reddot.x = 0;
    self.reddot.y = 0;
    self.reddot.alpha = 1;
    self.reddot.alignX = "center";
    self.reddot.alignY = "middle";
    self.reddot.horzAlign = "center";
    self.reddot.vertAlign = "middle";
    self.reddot setShader( "white", 3, 3);
    self.reddot.color = (1, 0, 0);
}