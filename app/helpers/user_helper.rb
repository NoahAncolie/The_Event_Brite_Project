module UserHelper
    def is_admin
        return Event.find_by(admin_id: current_user.id, id: params[:id])
    end
    def is_participating
        return Attendance.find_by(participant_id: current_user.id, event_id: params[:id])
    end
end
