/******************************************************************************************************************

Acest modul preia date de imagine dintr-un AXI stream, 
stocheaza o linie a imaginii intr-un buffer si apoi scoate linia in ordine inversa 
pentru a obtine un efect de flip orizontal. 
Utilizeaza un state machine simplu pentru a gestiona procesele de scriere si citire 
si se ocupa de sincronizarea intre interfetele slave si master AXI.

******************************************************************************************************************/

`timescale 1 ns / 1 ps



/*========================================[Parametrii Modulului]========================================*/
module ImageFlip #
(
    // Parametrii pentru Interfata Axi Slave Bus S00_AXIS
    parameter integer C_S00_AXIS_TDATA_WIDTH = 32,

    // Parametrii pentru Interfata Axi Master Bus M00_AXIS
    parameter integer C_M00_AXIS_TDATA_WIDTH = 32,
    parameter integer C_M00_AXIS_START_COUNT = 32,

    // Parametrii frecventei Clock
    parameter integer C_S00_AXIS_ACLK_FREQ_HZ = 100000000, // 100 MHz
    parameter integer C_M00_AXIS_ACLK_FREQ_HZ = 100000000  // 100 MHz
)
(
    // Porturile pentru Interfata Axi Slave Bus S00_AXIS
    input wire  s00_axis_aclk,
    input wire  s00_axis_aresetn,
    output wire  s00_axis_tready,
    input wire [C_S00_AXIS_TDATA_WIDTH-1 : 0] s00_axis_tdata,
    input wire [(C_S00_AXIS_TDATA_WIDTH/8)-1 : 0] s00_axis_tstrb,
    input wire  s00_axis_tlast,
    input wire  s00_axis_tvalid,

    // Porturile pentru Interfata Axi Master Bus M00_AXIS
    input wire  m00_axis_aclk,
    input wire  m00_axis_aresetn,
    output wire  m00_axis_tvalid,
    output wire [C_M00_AXIS_TDATA_WIDTH-1 : 0] m00_axis_tdata,
    output wire [(C_M00_AXIS_TDATA_WIDTH/8)-1 : 0] m00_axis_tstrb,
    output wire  m00_axis_tlast,
    input wire  m00_axis_tready
);



/*========================================[Parametrii Locali si Semnale]========================================*/
    // Parametrii pentru dimensiunea imaginii (examplu: 640 pixeli pe linie)
    localparam integer IMAGE_WIDTH = 640;

    // Semnal pentru buffer de linie (pentru flip orizontal)
    reg [C_S00_AXIS_TDATA_WIDTH-1:0] line_buffer [0:IMAGE_WIDTH-1];
    reg [$clog2(IMAGE_WIDTH)-1:0] write_ptr = 0;
    reg [$clog2(IMAGE_WIDTH)-1:0] read_ptr = IMAGE_WIDTH-1;
    reg line_complete = 1'b0;

    // Stari State Machine
    localparam IDLE = 1'b0, FLIP = 1'b1;
    reg state = IDLE;



/*========================================[Atributii de semnal AXI Stream]========================================*/
    // Semnale AXI Stream
    assign s00_axis_tready = (state == IDLE);
    assign m00_axis_tvalid = (state == FLIP) && m00_axis_tready;
    assign m00_axis_tdata = line_buffer[read_ptr];
    assign m00_axis_tstrb = {(C_M00_AXIS_TDATA_WIDTH/8){1'b1}};
    assign m00_axis_tlast = (read_ptr == 0);



/*========================================[State Machine si Bufferul de Linie]========================================*/
    always @(posedge s00_axis_aclk) begin
        if (~s00_axis_aresetn) begin
            write_ptr <= 0;
            read_ptr <= IMAGE_WIDTH-1;
            line_complete <= 1'b0;
            state <= IDLE;
        end else begin
            case (state)
                IDLE: begin
                    if (s00_axis_tvalid && s00_axis_tready) begin
                        line_buffer[write_ptr] <= s00_axis_tdata;
                        if (write_ptr == IMAGE_WIDTH-1) begin
                            write_ptr <= 0;
                            line_complete <= 1'b1;
                            state <= FLIP;
                        end else begin
                            write_ptr <= write_ptr + 1;
                        end
                    end
                end

                FLIP: begin
                    if (m00_axis_tready) begin
                        if (read_ptr == 0) begin
                            read_ptr <= IMAGE_WIDTH-1;
                            line_complete <= 1'b0;
                            state <= IDLE;
                        end else begin
                            read_ptr <= read_ptr - 1;
                        end
                    end
                end

                default: state <= IDLE;
            endcase
        end
    end

endmodule
