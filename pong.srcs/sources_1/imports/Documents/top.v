`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/17/2019 03:19:19 AM
// Design Name: 
// Module Name: top
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////

module top(
    input wire CLK,             // board clock: 100 MHz on Arty/Basys3/Nexys
    input wire RST_BTN,         // reset button
    input [4:0] button,
    output wire VGA_HS_O,       // horizontal sync output
    output wire VGA_VS_O,       // vertical sync output
    output wire [3:0] VGA_R,    // 4-bit VGA red output
    output wire [3:0] VGA_G,    // 4-bit VGA green outputoutput reg [C_LED_COUNT - 1 : 0] led
    output wire [3:0] VGA_B,    // 4-bit VGA blue output
    output [6 : 0] sseg_DG,                 // 7S display digit control.
    output sseg_DP,                         // Data point on the 7S display.
    output [3 : 0] sseg_AN,                 // 7S display anode control
    output [15:0] led                       // led control
    );

    wire rst = RST_BTN;  // reset is active high on Basys3 (BTNC)

    wire [9:0] x;  // current pixel x position: 10-bit value: 0-1023
    wire [8:0] y;  // current pixel y position:  9-bit value: 0-511
    wire animate;  // high when we're ready to animate at end of drawing
    wire [1:0] wButton_player1; // player1 button control
    wire [1:0] wButton_player2; // player2 button control
    assign button[2] = wButton_player1[0];
    assign button[4] = wButton_player1[1];
    assign button[1] = wButton_player2[0];
    assign button[3] = wButton_player2[1];
    
    wire [6 : 0] wSSeg_DG;  // 7S display wires
    wire wSSeg_DP;
    wire [3:0] wSSeg_AN;
    assign sseg_DG = wSSeg_DG;
    assign sseg_DP = wSSeg_DP;
    assign sseg_AN = wSSeg_AN;
    

    // generate a 25 MHz pixel strobe
    reg [15:0] cnt = 0;
    reg pix_stb = 0;
    always @(posedge CLK)
        {pix_stb, cnt} <= cnt + 16'h4000;  // divide by 4: (2^16)/4 = 0x4000

    // vga controller
    vga640x480 display (
        .i_clk(CLK),
        .i_pix_stb(pix_stb),
        .i_rst(rst),
        .o_hs(VGA_HS_O), 
        .o_vs(VGA_VS_O), 
        .o_x(x), 
        .o_y(y),
        .o_animate(animate)
    );

    wire sq, player1, player2;  // figures on the screen
    wire [11:0] sq_x1, sq_x2, sq_y1, sq_y2;  // 12-bit values: 0-4095 
    wire [11:0] player1_x1, player1_x2, player1_y1, player1_y2; // player1 position
    wire [11:0] player2_x1, player2_x2, player2_y1, player2_y2; // player2 postion
    wire [3:0] pPlayer1, pPlayer2;  //players points
    wire point_rst; // reset for points
    
    assign led[3:0] = pPlayer1;     // points on led for player1 and player2 (in binary)
    assign led[15] = pPlayer2[0];
    assign led[14] = pPlayer2[1];
    assign led[13] = pPlayer2[2];
    assign led[12] = pPlayer2[3]; 
    
    // practically the game happens inside this module
    square #(.H_SIZE(8), .IX(160), .IY(120)) sq_anim (
        .p_rst(point_rst),
        .i_clk(CLK), 
        .i_ani_stb(pix_stb),
        .i_rst(rst),
        .i_animate(animate),
        .p1_x1(player1_x1),
        .p1_x2(player1_x2),
        .p1_y1(player1_y1),
        .p1_y2(player1_y2),
        .p2_x1(player2_x1),
        .p2_x2(player2_x2),
        .p2_y1(player2_y1),
        .p2_y2(player2_y2),
        .o_x1(sq_x1),
        .o_x2(sq_x2),
        .o_y1(sq_y1),
        .o_y2(sq_y2),
        .pP1(pPlayer1),
        .pP2(pPlayer2),
        .rst(point_rst)
    );
    
    // creating player1 animation
    player #(.IX(40), .IY(240)) player1_anim (
        .button(wButton_player1),
        .i_clk(CLK), 
        .i_ani_stb(pix_stb),
        .i_rst(rst),
        .i_animate(animate),
        .o_x1(player1_x1),
        .o_x2(player1_x2),
        .o_y1(player1_y1),
        .o_y2(player1_y2)
    );
    
    // creating player2 animation
    player #(.IX(620), .IY(240)) player2_anim (
        .button(wButton_player2),
        .i_clk(CLK), 
        .i_ani_stb(pix_stb),
        .i_rst(rst),
        .i_animate(animate),
        .o_x1(player2_x1),
        .o_x2(player2_x2),
        .o_y1(player2_y1),
        .o_y2(player2_y2)
    );
    
    // 7S display controller
    ssg_DP ssg(
            .clk(CLK),
            .player1(pPlayer1),
            .player2(pPlayer2),
            .sseg_DG_o(wSSeg_DG),
            .sseg_DP(wSSeg_DP),
            .sseg_AN_o(wSSeg_AN)
    );
    
    // assign postion and colors for player1, player2 and ball
    assign sq = ((x > sq_x1) & (y > sq_y1) &
        (x < sq_x2) & (y < sq_y2)) ? 1 : 0;
        
    assign player1 = ((x > player1_x1) & (y > player1_y1) &
        (x < player1_x2) & (y < player1_y2)) ? 1 : 0;
        
    assign player2 = ((x > player2_x1) & (y > player2_y1) &
        (x < player2_x2) & (y < player2_y2)) ? 1 : 0;

    assign VGA_R[3] = sq;
    assign VGA_G[3] = player1;
    assign VGA_B[3] = player2;
    
endmodule
