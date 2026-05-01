.headersize (0x8090FB40 - 0x00CAD2C0)

; Hack the actor initialization variable to use the new standalone object
.org 
dh  0x1B6

; Hack the params of the draw function to pass in the segment offset of our new display list
.org 0x
; Replaces
;   lui     t9,0x603
;   addiu   t9,t9,-0x4d78
    lui     t9,0x603
    addiu   t9,t9,-0x4d78

; Hack the ovl_Arms_Hook params to use the new standalone object
.org 0x809105b0
; Replaces
;   lui     s8, 0x0501
;   mtc1    at, f24
;   li      s0, 0x0x03e8
;   addiu   s8, s8, -0x5a18
    lui     s8, 0x0600
    .skip   8
    addiu   s8, s8, 0x0C10

; Hookshot
; Replaces: addiu   t8, v1, 0x0008
;           sw      t8, 0x02C0(t7)

.org 0xCC4A6C
    ActorProfile Arms_Hook_Profile = {
        /**/ ACTOR_ARMS_HOOK,
        /**/ ACTORCAT_ITEMACTION,
        /**/ FLAGS,
        /**/ OBJECT_NewHookshot,
        /**/ sizeof(ArmsHook),
        /**/ ArmsHook_Init,
        /**/ ArmsHook_Destroy,
        /**/ ArmsHook_Update,
        /**/ ArmsHook_Draw
    };

        809105b0 3c 19 06 03     lui        t9,0x603
        809105b4 27 39 b2 88     addiu      t9,t9,-0x4d78

.org 0xF6D000 + 0x17870 + 0x18 ; gameplay_dangeon_keep file start + dlist offset + gDPSetTextureImage offset
.word   0xDE000000, 0x09000000 ; jump to the custom dlist at segment 09