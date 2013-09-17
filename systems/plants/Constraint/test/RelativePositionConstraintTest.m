function RelativePositionConstraintTest(varargin)
  r = RigidBodyManipulator(strcat(getDrakePath(),'/examples/PR2/pr2.urdf'));
  q_nom = zeros(r.getNumDOF(),1);
  constraintTester('RelativePositionConstraintTest', r, @makeCon, @(r) q_nom, @(r) q_nom, 10, varargin{:});
end

function con = makeCon(r)
  %n_pts = 4;
  bodyA_idx = findLinkInd(r,'r_gripper_palm_link');
  bodyB_idx = findLinkInd(r,'l_gripper_palm_link');
  rpy = 2*pi*rand(3,1) - pi;
  xyz = [0.2;0.2;0.2].*rand(3,1) - [0;0.1;0.1];
  lb = [-0.1;-0.1;-0.1];
  ub = [0.1;0.1;0.1];
  %pts = bsxfun(@minus,bsxfun(@times,(ub-lb),rand(3,n_pts)),(ub-lb)/2);
  %pts = 0.8*[[0;1;1],[0;-1;1],[0;-1;-1],[0;1;-1]].*repmat((ub-lb)/2,1,4);
  pts = 0.4*rand(3,1) - 0.2;

  T = [rpy2rotmat(rpy),xyz;zeros(1,3),1];

  con = RelativePositionConstraint(r,[0 1],pts,lb,ub,bodyA_idx,bodyB_idx,T)
end
