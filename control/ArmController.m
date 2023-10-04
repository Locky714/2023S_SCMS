classdef ArmController
    %ARM Summary of this class goes here
    %   Detailed explanation goes here

    properties (Constant)
        DEFAULT_STEPS_PER_METRE = 200;
        DEFAULT_IK_ERROR_MAX = 10^-3;
    end

    properties(Access = private)
        robot
        stepsPerMetre
        ikErrorMax
        currentState
        errorCode
    end

    methods
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%//Constructors///////////////////////////////////////////////////////////%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        function self = ArmController(robot,stepsPerMetre,ikErrorMax,qInit)
            %Instantiate class object
            %Setting member attributes to default values
            self.errorCode = 0;
            self.stepsPerMetre = self.DEFAULT_STEPS_PER_METRE;
            self.ikErrorMax = self.DEFAULT_IK_ERROR_MAX;
            self.currentState = armState.Init;
        
        
            if nargin > 0 % Just robot arm passed
                self.robot = robot;
                if nargin > 1 % Arm and steps per metre
                    self.stepsPerMetre = stepsPerMetre;
                end
                if nargin > 2 % Arm, steps and inv kinematic error max
                    self.ikErrorMax = ikErrorMax;
                end
                if nargin > 3 % All elements passed
                    self.robot.model.animate(qInit);
                else % No initial joint angles passed
                    self.robot.model.animate(zeros(1,self.robot.model.n));
                end
            else % Nothing passed!
                self.errorCode = 1;
                error('No robot passed to controller');
            end
        end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%//Getters////////////////////////////////////////////////////////////////%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        function jointPose = GetJointPose(self,jointNumber)
            %Get the pose transform for the specified joint
            % (returns empty if outside of joint bounds)
            if 0 > jointNumber || jointNumber > self.robot.model.n %OUT OF BOUNDS
                self.errorCode = 2;
                jointPose = zeros(4,4);
                error('Joint out of bounds');
            else %SELECTION WITHIN JOINT NUMBER
                if  ceil((self.robot.model.n)/2) > jointNumber %Joint closer to base
                    currentTransform = self.robot.model.base;
                    for i = 1:jointNumber
                        theta = self.robot.model.links(i).theta;
                        d = self.robot.model.links(i).d;
                        a = self.robot.model.links(i).a;
                        alpha = self.robot.model.links(i).alpha;

                        if isempty(theta)
                            theta = 0;
                        end
                        if isempty(alpha)
                            alpha = 0;
                        end


                        T = eye(4) * ...
                            trotz(rad2deg(theta), 'deg') * ...
                            transl(a,0,d) * ...
                            trotx(rad2deg(alpha), 'deg');

                        currentTransform.T = currentTransform.T * T;
                    end
                else %Joint closer to end effector
                    currentTransform = self.robot.model.fkine(self.robot.model.getpos).T;
                    for i = self.robot.model.n:jointNumber
                        theta = self.robot.model.links(i).theta;
                        disp('DEBUG3')
                        d = self.robot.model.links(i).d;
                        a = self.robot.model.links(i).a;
                        alpha = self.robot.model.links(i).alpha;
                        disp('DEBUG4')

                        T = trotz(rad2deg(theta)) * transl(a,0,d) * trotx(rad2deg(alpha));

                        currentTransform = currentTransform * inv(T);
                    end
                end
                jointPose = currentTransform;
            end
        end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%//Setters////////////////////////////////////////////////////////////////%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    end

end

%% CODE DUMP
%                 if  > jointNumber %Joint closer to base
%                     currentTransform = self.robot.base;
%                     for i = 1:jointNumber
%                         theta = self.robot.links(i).theta;
%                         d = self.robot.links(i).d;
%                         a = self.robot.links(i).a;
%                         alpha = self.robot.links(i).alpha;
% 
%                         currentTransform = currentTransform * trotz(theta);
%                         currentTransform = currentTransform * transl(0,0,d);
%                         currentTransform = currentTransform * transl(a,0,0);
%                         currentTransform = currentTransform * trotx(alpha);
%                     end
