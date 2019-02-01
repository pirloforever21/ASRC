'''
Compare performance of several algorithms: RHC, RHGD and RHPD on different objective function
Date: 08/23/2018
Author: Zhenhuan(Neyo) Yang
'''

import numpy as np
import pandas as pd
from matplotlib import pyplot as plt
import math

df = pd.read_csv('processed data.csv')
demand_total = df['Electricity:Facility [kW](Hourly)'].values
solar_total = df['Normalized Solar Energy [kWh]'].values

#
T = len(demand_total)
eta = 0.005
beta = 0.1
a = 0.02
b = 0.15
c = 0.1

def gradient_descent(variable, gradient, tol=1e-6, projection=lambda x: x, max_iter=1000, step_size=0.05, show=False):
    """
    Projected gradient descent.

    Inputs:
        variable: starting point
        grad: function mapping points to gradients
        function: compute function value at now variable
        tol: stopping threhold
        max_iter: maximum iteration
        step_size: learning rate
        projection(optional): function mapping points to points

    Returns:
        List of all points computed by projected gradient descent.
    """
    iteration = 0
    while (np.linalg.norm(gradient(variable)) > tol) & (iteration < max_iter):
        variable = projection(variable + step_size * (-gradient(variable)))
        iteration += 1
        if (iteration % 100 == 0) & (show):
            print('iteration: %d, gradient norm: %.9f' % (iteration, np.linalg.norm(gradient(variable))))

    return variable


def strongly_convex_gradient(variable, solar, demand, x0=0.0):
    variable_backward = np.append(x0, variable[:-1])
    variable_forward = np.append(variable[1:], variable[-1])
    gradient = 2 * a * variable + b * variable + 2 * eta * (variable + solar - demand) + beta * (
                2 * variable - variable_backward - variable_forward)

    return gradient


def strongly_convex_function(variable, solar, demand, x0=0.0):
    variable_backward = np.append(x0, variable[:-1])
    function = np.sum(a * variable ** 2 + b * variable + c + eta * (variable + solar - demand) + 0.5 * beta * (
                variable - variable_backward) ** 2)

    return function

def projection(variable):
    return np.maximum(variable,0.0)

# Offline algorithm
def OFF(x0=0.0,show = False):
    print('offline algorithm started...')
    x_OFF = np.full(T,x0)
    gradient = lambda variable: strongly_convex_gradient(variable,solar_total,demand_total)
    x_OFF = gradient_descent(variable=x_OFF,gradient=gradient,projection = projection,show=show)
    print('offline algorithm finished!')
    return x_OFF

# Receding horizon control algorithm
def RHC(W,x0 = 0.0,show = False):
    print('Receding horizon control started...')
    x_RHC = np.array([x0])
    solar_extend = np.append(solar_total,solar_total[:W])
    demand_extend = np.append(demand_total,demand_total[:W])
    for i in range(T):
        solar = solar_extend[i:i+W] # if W = 0 this return empty array
        demand = demand_extend[i:i+W]
        x_temp = np.zeros(W) # Warning!
        gradient = lambda variable: strongly_convex_gradient(variable,solar,demand,x0=x_RHC[-1])
        x_temp = gradient_descent(variable=x_temp,gradient=gradient,projection = projection)
        x_RHC = np.append(x_RHC,x_temp[0])
        if (i%1000 == 0) & (show):
            print('time step: %d, total steps: %d' % (i,T))
    x_RHC = np.delete(x_RHC,0)
    print('RHC finished!')
    return x_RHC

# Receding horizon gradient descent algorithm
def RHGD(W, x0 = 0.0, show = False):
    print('Receding horizon gradient descent started...')
    '''
    To be finish
    '''
    print('RHGD finished!')


def plot_window_vs_regret(objective, offline_algorithm, *online_algorithms, x0=0.0, show=False):
    offline_variable = offline_algorithm()
    offline_function = objective(offline_variable)

    window = 24
    log_regrets = []
    for online_algorithm in online_algorithms:
        log_regret = []
        for w in range(1, window):
            if show:
                print('Look forward window = %d, total window = %d' % (w, window))
            online_variable = online_algorithm(w)
            online_function = objective(online_variable)
            log_regret.append(math.log(math.fabs(online_function - offline_function)))

        t = np.arange(1, window)
        plt.plot(t, log_regret)
        log_regrets.append(log_regret)

    return np.array(log_regrets)

function = lambda variable: strongly_convex_function(variable,solar_total,demand_total)
log_regrets = plot_window_vs_regret(function,OFF,RHC,show=True)