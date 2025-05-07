"""add pilot messages fields

Revision ID: d8caf0406576
Revises: 00a26df416e1
Create Date: 2025-05-07 23:14:40.572699

"""
from typing import Sequence, Union

from alembic import op
import sqlalchemy as sa


# revision identifiers, used by Alembic.
revision: str = 'd8caf0406576'
down_revision: Union[str, None] = '00a26df416e1'
branch_labels: Union[str, Sequence[str], None] = None
depends_on: Union[str, Sequence[str], None] = None


def upgrade() -> None:
    op.add_column("pilots",sa.Column("infoMessages", sa.String, nullable=True))
    op.add_column("pilots",sa.Column("warnMessages", sa.String, nullable=True))
    op.add_column("pilots",sa.Column("errorMessages", sa.String, nullable=True))


def downgrade() -> None:
    op.drop_column("pilots","infoMessages")
    op.drop_column("pilots","warnMessages")
    op.drop_column("pilots","errorMessages")
