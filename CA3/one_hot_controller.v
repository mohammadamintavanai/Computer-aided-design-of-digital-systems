module con(input clk,input rst,input start,input DoneA,input DoneB,input downDone,output Done,output rst5,output loadA,output loadB,output shlA,output shlB,output cntU,output cntD,output loadOut,output shrOut);
    wire IDLE,WAIT,CHA,SHA,CHB,SHB,SHOUT;
    wire IDLE_inv,IDLE_out,WAIT_inv,WAIT_out,CHA_inv,CHA_out,SHA_inv,SHA_out,CHB_inv,CHB_out,SHB_inv,SHB_out,SHOUT_inv,SHOUT_out;
    //module one_hot_block(input clk,input rst,input [2:0]in,input signal,output state,output out_inv,output out);

    one_hot_block_first_state IDLEB(clk,rst,{IDLE_inv,SHOUT_out,1'd0},start,IDLE,IDLE_inv,IDLE_out);
    one_hot_block WAITB(clk,rst,{WAIT_out,IDLE_out,1'd0},start,WAIT,WAIT_inv,WAIT_out);
    one_hot_block CHAB(clk,rst,{WAIT_inv,SHA,1'd0},DoneA,CHA,CHA_inv,CHA_out);
    one_hot_block SHAB(clk,rst,{CHA_inv,1'd0,1'd0},1'd1,SHA,SHA_inv,SHA_out);
    one_hot_block CHBB(clk,rst,{CHA_out,SHB,1'd0},DoneB,CHB,CHB_inv,CHB_out);
    one_hot_block SHBB(clk,rst,{CHB_inv,1'd0,1'd0},1'd1,SHB,SHB_inv,SHB_out);
    one_hot_block SHOB(clk,rst,{CHB_out,SHOUT_inv,1'd0},downDone,SHOUT,SHOUT_inv,SHOUT_out);
    assign rst5 = WAIT;
    assign  loadA = WAIT_inv;
    assign shlA = SHA;
    assign cntU = SHA | SHB;
    assign shlB = SHB;
    assign loadB = WAIT_inv;
    assign loadOut = CHB_out;
    assign cntD = SHOUT;
    assign shrOut = SHOUT_inv;
    assign Done = SHOUT_out;


endmodule