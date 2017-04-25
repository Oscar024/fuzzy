% Cambiar manualmente
u0=[-0.888432319242775,-1,-0.182180554926379,0.343014396935482,1,1,-0.711852094322452,0.539291094227438,-1,0.698438707711641,-0.841091993328587,0.236367169029014,-0.116708520775987,-0.0359765593775743,-0.320886496400000,-0.886895392555168,0.255910082374094,-1,0.937664410610675,-0.0656584876792113,-0.603688768479889,-1,-0.132660093527088,-1,1,-1,0.757473092141483,0.179953470505303,-1,1,1,1,1,0.565814250338133,0.860217698676544,-0.286684913660706,-0.642718950730441,0.905968592091261,1,0.190540215433505]
u0 = sort(u0)        
        a = readfis('BaseRobotFA.fis');
        sys= find_system('Name','ProbotISCI2016');
        open_system('ProbotISCI2016');
        set_param(gcs,'SimulationCommand','start');
        pause(3);
        
        %Ordena los valore de forma ascendente que ayuda al traslape de la funcion
        u0 = sort(u0);
        %Cambiar los parametros de las funciones de membresia
        a.input(1).mf(1).params = [-1.72  u0(5) u0(7) u0(15)];
        a.input(1).mf(2).params = [u0(11) u0(22) u0(30)];
        a.input(1).mf(3).params = [u0(23) u0(31) u0(35) 1.72];
        a.input(2).mf(1).params = [-1.72 u0(6) u0(8) u0(16)];
        a.input(2).mf(2).params = [u0(12) u0(21) u0(29)];
        a.input(2).mf(3).params = [u0(24) u0(32) u0(36) 1.72];
        a.output(1).mf(1).params = [-1.8 u0(9) u0(12)];
        a.output(1).mf(2).params = [u0(13) u0(20) u0(28)];
        a.output(1).mf(3).params = [u0(25) u0(33) 1.8];
        a.output(2).mf(1).params = [-1.8 u0(10) u0(18)];
        a.output(2).mf(2).params = [u0(14) u0(19) u0(27)];
        a.output(2).mf(3).params = [u0(26) u0(34) 1.8];
 
        vmse = mse(data.signals.values(:,2) - data.signals.values(:,1));%llanta una
        wmse = mse(data.signals.values(:,4) - data.signals.values(:,3));%llanta dos
    
        best= vmse + wmse;
        disp('Current best: ');
        disp (best);
        save('a');
        writefis(a,'BaseRobotFA.fis');
        
        plot(XY.signals.values(:,1),XY.signals.values(:,2),xDyD.signals.values(:,1),xDyD.signals.values(:,2));
        