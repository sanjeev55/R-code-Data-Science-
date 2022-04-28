import numpy as np
import matplotlib.pyplot as plt
import random as rd



### Generate a random and normally distributed datasets
#Normal Distribution
fig, axs = plt.subplots(nrows=3, ncols=3, sharey=True, tight_layout=True)
for ax in axs.flat:
    mean = rd.randint(1,10)
    sd = rd.randint(1,10)
    data_normal = np.random.normal(mean, sd, 1000)
    ax.hist(data_normal, 20, label = mean)
    ax.set_title("mean =%s and sd = %s"%(mean,sd), fontsize = 8)

plt.show()


# In[5]:


#Exponential distribution
fig, axs = plt.subplots(3, 3, sharey=True, tight_layout=True)
for ax in axs.flat:
    s = rd.randint(1,1000)
    data_exponential = np.random.exponential(size=s)
    ax.hist(data_exponential, 20)
    ax.set_title("size %s"%s, fontsize = 8)

plt.show()


# In[6]:



#Binomial Distribution
fig, axs = plt.subplots(3, 3, sharey=True, tight_layout=True)
for ax in axs.flat:
    num = rd.randint(1,1000)
    p = rd.uniform(0,1)
    data_bionomial = np.random.binomial(n=num, p=p, size=100)
    ax.hist(data_bionomial, 20)
    ax.set_title("num =%s and p = %f"%(num,p), fontsize = 10)

plt.show()
# In[17]:


#Poisson Distribution
fig, axs = plt.subplots(3, 3, sharey=True, tight_layout=True)
for ax in axs.flat:
    lam = rd.randint(1,10)
    size = rd.randint(1,1000)
    data_possion = np.random.poisson(lam=lam, size=size)
    ax.hist(data_possion, 20)
    ax.set_title("lam =%s and size = %s"%(lam,size), fontsize = 10)

plt.show()
# In[8]:


#ChiSquare distribution
fig, axs = plt.subplots(3, 3, sharey=True, tight_layout=True)
for ax in axs.flat:
    df = rd.randint(1,20)
    size = rd.randint(1,1000)
    data_chisquare = np.random.chisquare(df=df, size=size)
    ax.hist(data_chisquare, 20)
    ax.set_title("df =%s and size = %s"%(df,size), fontsize = 10)

plt.show()




