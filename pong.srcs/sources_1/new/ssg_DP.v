`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/20/2019 01:06:17 AM
// Design Name: 
// Module Name: ssg_DP
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


module ssg_DP(
    input clk,
    input [3:0] player1,
    input [3:0] player2,
    output wire [6 : 0] sseg_DG_o,           
    output wire sseg_DP,
    output wire [3 : 0] sseg_AN_o
    );
   
    reg cnt = 0;
    reg [6:0] sseg_DG = 7'b0000000;
    reg [3:0] sseg_AN = 4'b1111;
    assign sseg_DG_o = sseg_DG;
    assign sseg_AN_o = sseg_AN;
    
    reg [16:0] refresh_counter; 

    // the first 18-bit for creating 2.6ms digit period
    // the other 2-bit for creating 4 LED-activating signals

    wire LED_activator; 

    always @( posedge clk ) 
        begin 
            refresh_counter <= refresh_counter + 1;
    end 
    
    assign LED_activator = refresh_counter[16];


    
    always @( posedge LED_activator ) 
        begin
            cnt = cnt + 1;
            if( cnt )
            begin
                sseg_AN = 4'b0111;
                case( player2 )
                    4'b0000: sseg_DG = 7'b1000000; // "0"  
                    4'b0001: sseg_DG = 7'b1111001; // "1" 
                    4'b0010: sseg_DG = 7'b0100100; // "2" 
                    4'b0011: sseg_DG = 7'b0110000; // "3" 
                    4'b0100: sseg_DG = 7'b0011001; // "4" 
                    4'b0101: sseg_DG = 7'b0010010; // "5" 
                    4'b0110: sseg_DG = 7'b0000010; // "6" 
                    4'b0111: sseg_DG = 7'b1111000; // "7" 
                    4'b1000: sseg_DG = 7'b0000000; // "8"  
                    4'b1001: sseg_DG = 7'b0010000; // "9"
                endcase
            end
            else
            begin
                sseg_AN = 4'b1110;
                case( player1 )
                  4'b0000: sseg_DG = 7'b1000000; // "0"  
                  4'b0001: sseg_DG = 7'b1111001; // "1" 
                  4'b0010: sseg_DG = 7'b0100100; // "2" 
                  4'b0011: sseg_DG = 7'b0110000; // "3" 
                  4'b0100: sseg_DG = 7'b0011001; // "4" 
                  4'b0101: sseg_DG = 7'b0010010; // "5" 
                  4'b0110: sseg_DG = 7'b0000010; // "6" 
                  4'b0111: sseg_DG = 7'b1111000; // "7" 
                  4'b1000: sseg_DG = 7'b0000000; // "8"  
                  4'b1001: sseg_DG = 7'b0010000; // "9"
                endcase
            end
            
        end
    
endmodule
