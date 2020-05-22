`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/19/2019 02:55:53 PM
// Design Name: 
// Module Name: square
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


module player #(
    H_SIZE=5,      // horizontal size
    V_SIZE=80,      // vertical size
    IX=320,         // initial horizontal position of player
    IY=240,         // initial vertical position of player
    D_WIDTH=640,    // width of display
    D_HEIGHT=480    // height of display
    )
    (
    input [1:0] button,
    input wire i_clk,         // base clock
    input wire i_ani_stb,     // animation clock: pixel clock is 1 pix/frame
    input wire i_rst,         // reset: returns animation to starting position
    input wire i_animate,     // animate when input is high
    output wire [11:0] o_x1,  // player left edge
    output wire [11:0] o_x2,  // player right edge
    output wire [11:0] o_y1,  // player top edge
    output wire [11:0] o_y2   // splayer bottom edge
    );

    reg [11:0] x = IX;   // horizontal position of player
    reg [11:0] y = IY;   // vertical position of player

    assign o_x1 = x - H_SIZE;  // left
    assign o_x2 = x + H_SIZE;  // right
    assign o_y1 = y - V_SIZE;  // top
    assign o_y2 = y + V_SIZE;  // bottom

    always @ (posedge i_clk)
    begin
        if (i_rst)  // on reset return to starting position
        begin
            x <= IX;
            y <= IY;
        end
        if (i_animate && i_ani_stb && button[0] && !button[1]) // if button pressed move
        begin
        
            if (y == V_SIZE  + 1)  // edge of square at top of screen
                y <= y;  // do not move
            else    y <= y - 3;  // move up          
        end
        if (i_animate && i_ani_stb && button[1] && !button[0])
        begin
        
            if (y == (D_HEIGHT - V_SIZE - 1))  // edge of square at bottom
                y <= y;  // do not move
            else    y <= y + 3;  // move down              
        end
    end    
    
endmodule
