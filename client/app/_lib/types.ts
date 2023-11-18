export enum QuestStatus {
  Active = "active",
  Ended = "ended",
}
export interface PartnerDashboardQuest {
  img: string;
  title: string;
  timer: string;
  participants: string;
  bounty: string;
  status: QuestStatus;
}

export interface FileValues {
  questPic: File | null;
  char1: File | null;
  char2: File | null;
  char3: File | null;
  char4: File | null;
  char5: File | null;
  char6: File | null;
  char7: File | null;
  char8: File | null;
}
