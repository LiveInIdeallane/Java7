package service.RoomS;


import entity.RoomS.Room;

import java.util.List;

public interface RoomService {

    /** 新增房间 */
    boolean addRoom(Room room);

    /** 修改房间 */
    boolean updateRoom(Room room);

    /** 删除房间 */
    boolean deleteRoom(Integer id);

    /** 根据ID查询 */
    Room getRoomById(Integer id);

    /** 查询所有房间 */
    List<Room> getAllRooms();

    /** 根据楼层查询房间列表 */
    List<Room> getRoomsByFloor(String floor);

    /** 查询所有楼层（去重） */
    List<String> getAllFloors();
}