package one.yiran.dashboard.event;

import one.yiran.dashboard.entity.SysChannel;
import org.springframework.context.ApplicationEvent;

public class ChannelEvent extends ApplicationEvent {

    private SysChannel channel;

    public ChannelEvent(Object source, SysChannel mechannelssage) {
        super(source);
        this.channel = mechannelssage;
    }

    public SysChannel getChannel() {
        return channel;
    }
}