--/////////////////////////////////////////          ----FEATURE LIST----            ///////////////////////////////////////////--
--////                                                                                                                      ////--
--////                                        No need to manually resource.AddFile                                          ////--
--////                                                                                                                      ////--
--////                       Three tables to add the different sounds to the different type of wins.                        ////--
--////                                                                                                                      ////--
--////        No need to add "sound/" in the tables, if you do, you'll actually be screwing up the resource.addfile         ////--
--////                                                                                                                      ////--
--////                     Sounds are randomly chosen inside the table matching the proper win method                       ////--
--////                                                                                                                      ////--
--//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////--

--/////////////////////////////////////////        ----WARNINGS AND TIPS----         ///////////////////////////////////////////--
--////                                                                                                                      ////--
--////                                   Remember that you can only use "/" and not "\"                                     ////--
--////                                                                                                                      ////--
--//// Remember to keep a table actually not fully empty to avoid code breaking. You can even just leave a wrong path in it ////--
--////                                                                                                                      ////--
--////                             For a guide on how to add new sounds, check the workshop page                            ////--
--////                                                                                                                      ////--
--//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////--

-- This is our end of round music
resource.AddFile("sound/innocentswin.mp3")
resource.AddFile("sound/traitorswin.mp3")

local function PlayMusic(wintype)
   if wintype == WIN_INNOCENT then
      BroadcastLua('surface.PlaySound("innocentswin.mp3")')

   elseif wintype == WIN_TRAITOR then
      BroadcastLua('surface.PlaySound("traitorswin.mp3")')

   elseif wintype == WIN_TIMELIMIT then
      BroadcastLua('surface.PlaySound("innocentswin.mp3")')
   end
end
hook.Add("TTTEndRound", "MyMusic", PlayMusic)