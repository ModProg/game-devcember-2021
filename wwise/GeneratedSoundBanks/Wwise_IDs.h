/////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Audiokinetic Wwise generated include file. Do not edit.
//
/////////////////////////////////////////////////////////////////////////////////////////////////////

#ifndef __WWISE_IDS_H__
#define __WWISE_IDS_H__

#include <AK/SoundEngine/Common/AkTypes.h>

namespace AK
{
    namespace EVENTS
    {
        static const AkUniqueID FOOTSTEPS = 2385628198U;
    } // namespace EVENTS

    namespace STATES
    {
        namespace PLAYERLIFE
        {
            static const AkUniqueID GROUP = 444815956U;

            namespace STATE
            {
                static const AkUniqueID ALIVE = 655265632U;
                static const AkUniqueID DEAD = 2044049779U;
                static const AkUniqueID NONE = 748895195U;
            } // namespace STATE
        } // namespace PLAYERLIFE

    } // namespace STATES

    namespace SWITCHES
    {
        namespace MUSIC
        {
            static const AkUniqueID GROUP = 3991942870U;

            namespace SWITCH
            {
                static const AkUniqueID LEVEL = 2782712965U;
                static const AkUniqueID MAIN = 3161908922U;
                static const AkUniqueID PAUSE = 3092587493U;
            } // namespace SWITCH
        } // namespace MUSIC

        namespace PLAYER_FOOTSTEP_SURFACE
        {
            static const AkUniqueID GROUP = 1725899499U;

            namespace SWITCH
            {
                static const AkUniqueID DIRT = 2195636714U;
                static const AkUniqueID GRAVEL = 2185786256U;
                static const AkUniqueID METAL = 2473969246U;
                static const AkUniqueID WOOD = 2058049674U;
            } // namespace SWITCH
        } // namespace PLAYER_FOOTSTEP_SURFACE

    } // namespace SWITCHES

    namespace TRIGGERS
    {
        static const AkUniqueID DEATH_SOUND = 2104926633U;
    } // namespace TRIGGERS

    namespace BANKS
    {
        static const AkUniqueID INIT = 1355168291U;
        static const AkUniqueID MUSIC_TEST_SOUNDBANK = 3471173579U;
        static const AkUniqueID PLAYERMOVEMENT = 1350496757U;
    } // namespace BANKS

    namespace BUSSES
    {
        static const AkUniqueID ENVIRONMENT = 1229948536U;
        static const AkUniqueID MASTER_AUDIO_BUS = 3803692087U;
        static const AkUniqueID MUSIC = 3991942870U;
        static const AkUniqueID SFX = 393239870U;
    } // namespace BUSSES

    namespace AUDIO_DEVICES
    {
        static const AkUniqueID NO_OUTPUT = 2317455096U;
        static const AkUniqueID SYSTEM = 3859886410U;
    } // namespace AUDIO_DEVICES

}// namespace AK

#endif // __WWISE_IDS_H__
