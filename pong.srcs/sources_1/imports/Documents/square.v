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


module square #(
    H_SIZE=80,      // half square width (for ease of co-ordinate calculations)
    IX=320,         // initial horizontal position of square centre
    IY=240,         // initial vertical position of square centre
    IX_DIR=1,
    IY_DIR=1,
    D_WIDTH=640,    // width of display
    D_HEIGHT=480    // height of display
    )
    (
    input wire p_rst,         // point gained reset
    input wire i_clk,         // base clock
    input wire i_ani_stb,     // animation clock: pixel clock is 1 pix/frame
    input wire i_rst,         // reset: returns animation to starting position
    input wire i_animate,     // animate when input is high
    input wire [11:0] p1_x1,  // player1 coordinates
    input wire [11:0] p1_x2,  
    input wire [11:0] p1_y1,  
    input wire [11:0] p1_y2,  
    input wire [11:0] p2_x1,  // player2 coordinates
    input wire [11:0] p2_x2,  
    input wire [11:0] p2_y1,  
    input wire [11:0] p2_y2,  
    output wire [11:0] o_x1,  // square left edge: 12-bit value: 0-4095
    output wire [11:0] o_x2,  // square right edge
    output wire [11:0] o_y1,  // square top edge
    output wire [11:0] o_y2,  // square bottom edge
    output wire [3:0] pP1,  // player1 points
    output wire [3:0] pP2,  // player2 points
    output wire rst
        );

    reg [11:0] x = IX;   // horizontal position of square centre
    reg [11:0] y = IY;   // vertical position of square centre
    reg x_dir = IX_DIR;  // horizontal anmation direction
    reg y_dir = IY_DIR;  // vertical animation direction
    reg pRst_1 = 0;     // point reset for player1
    reg pRst_2 = 0;     // point reset for player2
    reg [3:0] player1 = 4'b0000;    // register for player1 points
    reg [3:0] player2 = 4'b0000;    // register for player2 points

    assign o_x1 = x - H_SIZE;  // left
    assign o_x2 = x + H_SIZE;  // right
    assign o_y1 = y - H_SIZE;  // top
    assign o_y2 = y + H_SIZE;  // bottom
    assign pP1 = player1;
    assign pP2 = player2;
    assign rst = ( pRst_1 || pRst_2 ); // OR reset assignment 

    always @ ( posedge i_clk )
    begin
        if ( i_rst )  // hard reset (with button): start like begging
        begin
            x <= IX;
            y <= IY;
            x_dir <= IX_DIR;
            y_dir <= IY_DIR;
            player1 = 4'b0000;
            player2 = 4'b0000;
        end
        if ( pRst_1 || ( player1 == 4'b1010 ) )  // reset for point of player1
        begin
            x <= IX;       // starting places
            y <= IY;
            x_dir <= 1;     // starting ball direction
            y_dir <= 1;
            pRst_1 = 0;
            if( player1 == 4'b1010 )    // if it is point number 10, win obtained so reset
                begin
                    player1 = 4'b0000;
                    player2 = 4'b0000;
                end               
        end
        if ( pRst_2 || ( player2 == 4'b1010 ) )  // reset for point of player2
        begin
            x <= 520;       // starting places
            y <= IY;
            x_dir <= 0;     // starting direction
            y_dir <= 1;
            pRst_2 = 0;
            if( player2 == 4'b1010 )    // if it is point number 10, win obtained so reset
                begin
                    player1 = 4'b0000;
                    player2 = 4'b0000;
                end   
            
        end
        if (i_animate && i_ani_stb)
        begin
            x <= (x_dir) ? x + 2 : x - 2;  // move left if positive x_dir
            y <= (y_dir) ? y + 2 : y - 2;  // move down if positive y_dir

            if ( (x <= p1_x2 + H_SIZE + 1) && ( y + H_SIZE >= p1_y1 ) && ( y - H_SIZE <= p1_y2 ) )  // collision with player1 and ball
                x_dir <= 1;  // change direction to right
                
            if ( (x >= (p2_x1 - H_SIZE - 1)) && ( y + H_SIZE >= p2_y1 ) && ( y - H_SIZE <= p2_y2 ) )  // collision with player2 and ball
                x_dir <= 0;  // change direction to left
                
            if (x <= H_SIZE + 1)  // point for player1
                begin
                    x_dir <= 1;  // change direction to right
                    player1 = player1 + 1;
                    pRst_1 = 1; // point reset
                end
                
            if (x >= (D_WIDTH - H_SIZE - 1))  // point for player2
                begin
                    x_dir <= 0;  // change direction to left
                    player2 = player2 + 1;
                    pRst_2 = 1;  // point reset
                end   
                
            if (y <= H_SIZE + 1)  // edge of ball at top of screen
                y_dir <= 1;  // change direction to down
                
            if (y >= (D_HEIGHT - H_SIZE - 1))  // edge of ball at bottom
                y_dir <= 0;  // change direction to up  
                            
        end
    end
endmodule
