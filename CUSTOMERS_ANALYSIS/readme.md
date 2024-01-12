# Customer Analysis

<ins>**Overview**</ins>

The primary purpose of a business is to make a profit, which is crucial for its survival and growth.
Data collection and analysis can enable a company understand its customer base and
market trends, ultimately leading to more targeted marketing strategies,
efficient resource allocation and enhanced profitability.

<ins>**Data Structure**</ins>

The data follows Medallion architecture, see definition by **[Databricks](https://www.databricks.com/glossary/medallion-architecture)**

The bronze(raw) table consists of two tables(cvs file):customers and orders table

**Table 1: Customers Information**

- id(int):is a unique identifier for each customer,
- firstname(text):stores the customer's given first name
- lastname(text): stores the customer's given last name
- email(text): holds the customer's email address
- city(text): indicates the customer's city of residence
- birth_date(text): records the customer's date of birth

**Table 2: Orders Information**

- orderID(text): serves as a unique identifier for each order placed
- customer_id(int): links to the ID of the customer who placed the order
- order_amount(int): the value of the order
- currency(text):the currency in which the order was made
- full_country_name(text): the country of the order's origin
- purchase_date(varchar): indicates date of order
- product_category(text):the category the order belongs to

<ins>**Code Desription**</ins>

The script starts with running code for cleaning the bronze customer table and orders table into an silver table for the following analysis following analysis:

1. Identification of the anual top spenders accross countries.This analysis helps in understanding which geographical regions are the most lucrative and identifying key market segments.
2. International top spenders to understand the company's client base in the international market.This is essential for strategizing international market expansion.
3. Lastly, insights on customer's lifetime purchase to get overall spending behaviour.This can be used for accessing long-term customer value, understanding customer loyalty trends, and developing strategies for customer retention and value maximization.

<ins>**Conclusion/Recommendations**</ins>

1. **The Top Spenders:**

The top 10 spenders generated about 3% profits of the entire client base.
An Elite member group curating perosnal services can be created for these high value customers. They can be offered special discounts and offers, early access to new products and feedbackks making them feel like a part of the company.
Personal services can include offering them customized products, dedicated account manager and personal shopping assistant.
Lastly, collaborations with other businesses can also be formed to offer exclusive deals, such as hotel upgrades, airline lounge access, premium car rental services and invitation to exclusive events.

2. **The internaltional market**

The internaltional market showed the highest purchase from Asia.
Insishts on this analysis can help in promoting marketing campaigns for the local audience of each top market region. customization of products with variations in product design, features, or even packaging can be proposed. Identification of areas of improvement and new emerging opportunities in such regions can also be identified.

3. **The customer's lifetime analysis:**

The lifetime analysis gave a value of $19,000 for the highest spender.
Insights on lifetime analysis help understand the history and level of a customer's engagement. The behaviour of customers can be understood and services can be tailored to various customers as needed to increase engagement and returns.
Also, understanding customer's engagement can reveal how they can be receptive to additional products or upgraded services, hence cross-selling can be considered. These cudtomers can be encouraged to refer new customers. Such referrals can be leveraged to acquire new similar customers.
Most reward recommendations for the proposed Elite members are also applicable to highest spenders for customer retion and maximizing value.

Generally, companies can use such insights to make data driven decisons.
