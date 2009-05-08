package org.red5.io.udp;

import java.util.Random;
import java.util.concurrent.ConcurrentHashMap;
import java.util.concurrent.ConcurrentMap;

import org.red5.server.net.udp.UDPHeader;

abstract public class Converter
{
    static private final ConcurrentMap<Class<?>, Converter> typeToConverter = new ConcurrentHashMap<Class<?>, Converter>();
    static private final ConcurrentMap<Class<?>, Converter> classToConverter = new ConcurrentHashMap<Class<?>, Converter>();

    static private final ConcurrentMap<Short, Class<?>> idToClass = new ConcurrentHashMap<Short,Class<?>>();
    static private final ConcurrentMap<Class<?>, Short> classToId = new ConcurrentHashMap<Class<?>,Short>();

    static
    {
        register(UDPHeader.class, (short) 1);
    }

    public static void register(Class<?> T)
    {
        short id = generateId();

        while (idToClass.containsKey(id) || id == 0)
        {
            id = generateId();
        }

        register(T, id);
    }

    private static void register(Class<?> T, short Id)
    {
        System.out.println("Registering Ttpe: " + T.getName());
        idToClass.put(Id, T);
        classToId.put(T, Id);
    }

    public static void registerConverter(Class<?> T, Converter ClassConverter)
    {
        typeToConverter.put(T, ClassConverter);
    }

    public static short getRegisteredClassId(Class<?> T)
    {
        short id;

        if (classToId.containsKey(T))
        {
            return classToId.get(T);
        }

        return -1;
    }

    public static Class<?> getRegisteredClass(short id)
    {
        if (idToClass.containsKey(id))
        {
            return idToClass.get(id);
        }

        return null;
    }

    public static Converter getConverter(Class<?> T)
    {
        if (typeToConverter.containsKey(T))
        {
            return typeToConverter.get(T);
        }

        return null;
    }

    private static short generateId() 
    {
        return (short) new Random().nextInt(1000); 
    }

    abstract public void writeObjectData(Object object);
}
