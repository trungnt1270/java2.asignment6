package fa.training.dao;

import fa.training.model.Item;

import java.sql.SQLException;
import java.util.List;

public interface ItemDAO {
    /**
     * This method is for saving items to the database, using batch.
     * @method addItems
     * @param items
     * @return true if saves success, else false
     * @throws SQLException
     */
    boolean addItem(List<Item> items) throws SQLException;

    /**
     * This method is for deleting items form the database, using batch.
     * @param items
     * @return true if deletes success, else false
     * @throws SQLException
     */
    boolean deleteItems(List<Item> items) throws SQLException;

    /**
     * Exec a query to get all items of a specific bill, using batch.
     * @method getAllByBillCode
     * @param billCode
     * @return list of items
     * @throws SQLException
     */
    List<Item> getAllByBillCode(String billCode) throws SQLException;

    /**
     * Exec a query to check an item was exist or not.
     * @method checkItemExist
     * @param item
     * @return true if exist, else false
     * @throws SQLException
     */
    boolean checkItemExist(Item item) throws SQLException;
}
