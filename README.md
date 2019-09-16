<h1 align="center" id="urls">MySQL eCommerce Database</h1>
<h4 align="center">Get an eCommerce database up and running quicker with a ready-made MVP (Minimum Viable Product) solution.</h4>

<p align="center">
<a href="http://amarlearning.mit-license.org/"><img src="https://img.shields.io/pypi/l/pyzipcode-cli.svg" alt="mit license"></a>
<a href="https://github.com/runninguru/MySQL-eCommerce/issues"><img src="https://camo.githubusercontent.com/926d8ca67df15de5bd1abac234c0603d94f66c00/68747470733a2f2f696d672e736869656c64732e696f2f62616467652f636f6e747269627574696f6e732d77656c636f6d652d627269676874677265656e2e7376673f7374796c653d666c6174" alt="Issue"></a>
<img src="http://kylebirch.info/images/build_passing.png">
</p>
Includes scripts, functions, and procedures you will need to implement an eCommerce website without needing to reinvent the wheel.

## OK, so what can it do?

<ul>
<li>Catalog the items in your inventory. Does not currently store the quantity of each item or any shipping/recieving issues.</li>
<li>Stores and automatically tracks pricing information on all products in your catalog, including base-price, seasonal pricing, discounts, etc.</li>
<li>Maintain information on all website users, including account information, credit cards, billing & shipping addresses, contact information, etc.</li>
<li>This db is only designed for use in the USA (and the US Dollar). This is not designed to support international currency or international law. If you want to get it to work in a different country/currency, you are free to create a fork of this project.</li>
<li>No 'group accounts', or in other words, it's designed for one account per person. If you peruse the code, you will notice that it does include some code that will be used to implement this in future releases.</li>
<li>Not currently designed for full inventory/shipping management: i.e., inventory levels, orders, and deliveries. It currently tracks which products are available as well as each transaction the product is purchased in. </li>
</ul>


## Features I want to support in future releases

<ul>
  <li>Stored functions and procedures, which are not implemented yet.</li>
<li>Fully integrated Inventory Management tracking, including inventory levels, orders, sales, and deliveries.</li>
<li>Support for tax-exempt entities, as well as 'group accounts' or other entities, rather than just 'individual' (single-person) accounts.</li>
<li>tracking & managing product returns & refunds</li>
</ul>

## Table Descriptions
as you can notice, any table ending in '_type' is a lookup table used to ensure valid input into the associated foreign-key-constrained column. Also, 'city', 'state', and 'postal_code' are basically lookup tables.

<ul>
<li>system_user
<ul>
<li>A list of all database users who have permission to access this database.</li>
<li>This table is NOT updated automatically to reflect the current database user list, so your DBA must keep this table updated.</li>
</ul>
</li>

<li>system_user_type
<ul>
<li>A lookup table that determines the type of database user.</li>
</ul>
</li>

<li>account
<ul>
<li>Used to store essential account information and foreign keys for relational data (contact, credit_card, transaction, and address tables.</li>
</ul>
</li>

<li>account_type
<ul>
<li>A lookup table that determines the type of account.</li>
<li>A common example may be for you to store both customer and admin accounts in this database, and as a result, a foreign key reference to this table is used to indicate the type of account.</li>
</ul>
</li>

<li>contact
<ul>
<li>Represents all of the contact information for an individual account. Keeping contact and account tables separate will makes it easier to accommodate multi-user accounts in the future.</li>
<li>For now, there is a 1-to-1 relationship between contact and account.</li>
</ul>
</li>

<li>contact_type
<ul>
<li>A lookup table that determines the type of contact. This may not be necessary. It might be depricated for future versions, although This might be necessary in order to fully implement multi-user accounts.</li>
</ul>
</li>


<li>credit_card
<ul>
<li>Stores credit card information for each credit card.</li>
<li>Each account can have 1-to-many credit cards.</li>
</ul>
</li>

<li>credit_card_type
<ul>
<li>A lookup table that determines the type of credit card, such as Visa, MasterCard, DiscoverCard, etc.</li>
</ul>
</li>

<li>transaction
<ul>
<li>Represents a single transaction. Has a foreign key reference to account. An account may have 1-to-many transactions.</li>
<li>NOTE: the transaction.transaction_date column may seem redundant in light of the transaction.creation_date column, but that is not true. The transaction.creation_date column is used to track the date each row was created, while transaction.transaction_date tracks the date of the transaction. If the data type of a column in the table needs to be changed, for example, you might transfer the data to a temporary table, drop the table, and re-create the table with the new changes, in which case the value in the transaction.creation_date column will change, but the transaction.transaction_date column will not.</li>
</ul>
</li>

<li>transaction_type
<ul>
<li>A lookup table that determines the type of transaction.</li>
<li>This table may be depricated in the future. I'm including it as a prospective member, but i'm not sure it is necessary.</li>
</ul>
</li>

<li>transaction_item
<ul>
<li>An item that was purchased in a particular transaction.</li>
<li>Each transaction can have 1-to-many transaction-items.</li>
</ul>
</li>

<li>item
<ul>
<li>A inventory of all products available to be sold.</li>
</ul>
</li>

<li>item_category
<ul>
<li>Determines the category of any given item in the database inventory.</li>
<li>There is a one-to-one relationship between an item and its item_category</li>
</ul>
</li>

<li>item_subcategory
<ul>
<li>Same as item_category, just to define categories underneath categories in item_category.</li>
<li>There can be 1-to-many subcategories(in item_subcategory) per each category(in item_category).</li>
</ul>
</li>

<li>price
<ul>
<li>Store price information, including base price, sale prices, custom price duration, discounts, etc.</li>
<li>Capable of storing price information based on a time-frame, so you don't need to manually edit the price the day a special price goes live (or ends).</li>
</ul>
</li>

<li>price_type
<ul>
<li>A lookup table that determines the type of price.</li>
<li>Common examples include base price, seasonal discount price, holiday price, etc.</li>
</ul>

</li>
<li>address
<ul>
<li>Stores address information associated with accounts.</li>
<li>A user may have 1-to-many addresses per account.</li>
<li>This database will not constrain postal codes, cities, and states to ensure proper addresses. If a user enters the wrong address, either you can handle that ouside of the database or let the user suffer for their foolishness.</li>
</ul>
</li>

<li>address_type
<ul>
<li>A lookup table that defines the type of address. In this case, an address can either be a billing address or shipping address.</li>
</ul>
</li>

<li>city
<ul>
<li>A lookup table that defines the city for addresses.</li>
<li>If you want to create a version of this database which supports any country other than the USA, you will need to fork this project. </li>
</ul>
</li>

<li>state
<ul>
<li>A lookup table that defines the state for addresses.</li>
<li>If you want to create a version of this database which supports any country other than the USA, you will need to fork this project. </li>
</ul>
</li>

<li>postal_code
<ul>
<li>A lookup table that defines the postal code for addresses.</li>
</ul>
</li>
</ul>

## Contributing

Feel free to contribute!

### Code Style & Conventions

<ul>
<li>Each Primary Key index starts at 1001. This way, each table has 1000 rows you can experiment with when debugging, altering database designs, etc.</li>
<li>A column whose name ends in '_type' shall be a foreign key reference to the lookup table with the same name.</li>
<li>Capitalize reserved words.</li>
<li>commas before columns.</li>
<li>indent using spaces.</li>
<li>Each table has 4 columns used to track data entry:

<ul>
<li>created_by</li>
<li>creation_date</li>
<li>last_updated_by</li>
<li>last_update_date</li>
</ul>

</li>

</ul>
These columns are not designed to be a robust logging mechanism. Think of them as a development/audit tool used to track the <i>most recent</i> changes made to each row in a table. The created_by & last_upated_by columns are populated with data based on the current database user. At the same time, though, permission to edit data in these columns is restricted, and values in these columns are updated/inserted with triggers. That way, when a db user commits an INSERT or UPDATE, a trigger automatically populates these four columns with the appropriate information.  

## Contributors
[:arrow_up:\[Back to Top\]](https://github.com/runninguru/MySQL-eCommerce)

Following is a list of contributors:

Be the first!

## Issues
[:arrow_up:\[Back to Top\]](https://github.com/runninguru/MySQL-eCommerce)

You can report the bugs at the [issue tracker](https://github.com/runninguru/MySQL-eCommerce/issues)

***

## License
[:arrow_up:\[Back to Top\]](https://github.com/runninguru/MySQL-eCommerce)

Kyle Birch([@runninguru](http://github.com/runninguru)) under [MIT License](https://choosealicense.com/licenses/mit/) 
