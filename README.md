## Essential Model with Whole Body Control

This repository contains an extension of the Essential Model used in generating gait trajectories. This new formulation allows the essential model to generate whole-body trajectories, which improves balance.
A task priority can be defined by weights in the optimization problem.

Overview

* The original essential model obtains a desired ZMP by finding center of mass trajectories.
* This version obtains a desired ZMP by finding whole body trajectories (center of mass, arms, hip orientation)
* Trajectories are obtained by an optimization problem formulated as a quadratic programming problem.
* Whole body trajectories result in an improvement in robustness in balance and walking.

Features

* The controller allows the selection of which variables are completely constrained to tracking a trajectory and which variables can be modified in order to help balance.
* ZMP trajectories can be imposed to be tracked by the complete dynamics of the robot
* The dynamics evolve inside a reduced order model, meaning fewer decision variables and fewer constraints in the optimization problem without any simplifications in the dynamics.
