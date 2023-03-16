%% Clean
clc; 
close all;

% this IP is the vm ip
Robot_Dog_IP = '192.168.12.184';
Robot_Dog_Port = 1145;

Control_Command = zeros(1,11,'single');
%% Motive coordiate frame
% wall wall wall wall wall
%        ^ z
%        |
%        |
% x <----O y(pointing up)
% wall computer wall

%% Robot dog command
%
%     +(11) +(9)  -(11)
%     +(10)  dog  -(10)
%           -(9)
%
%% System Parameters

K_v = 1; % Porportional constant on velocity action
K_i = 1;  % Integral
% constant on velocity action
K_h = 1; % Proportional constant on angle action


%% Instantiate client object to run Motive API commands
% https://optitrack.com/software/natnet-sdk/

% Create Motive client object
dllPath = fullfile('d:','StDroneControl','NatNetSDK','lib','x64','NatNetML.dll');
assemblyInfo = NET.addAssembly(dllPath); % Add API function calls
theClient = NatNetML.NatNetClientML(0);

% Create connection to localhost, data is now being streamed through client object
HostIP = '127.0.0.1';
theClient.Initialize(HostIP, HostIP); 

Dog_ID = 1; % Rigid body ID of the drone from Motive

% fig = figure();
% ax = axes('Parent',fig);
% line_handle = plot(ax,Dog_Pos(2),Dog_Pos(3),'o');
while true
    [Dog_Pos] = Get_Dog_Postion(theClient, Dog_ID);
    disp(Dog_Pos(4));
%     set(line_handle, 'XData',Dog_Pos(2),'YData',Dog_Pos(3))
%     drawnow;
    pause(0.1);
end


